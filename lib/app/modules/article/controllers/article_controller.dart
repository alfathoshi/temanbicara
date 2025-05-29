import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config/config.dart';

class ArticleController extends GetxController {
  final box = GetStorage();
  var articles = <Map<String, dynamic>>[].obs;
  var isLoadingInitial = true.obs;
  var isLoadingMore = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var hasMoreData = true.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchArticles(page: currentPage.value, isInitialLoad: true);
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMoreData.value &&
        !isLoadingMore.value) {
      fetchArticles(page: currentPage.value + 1);
    }
  }

  Future<void> fetchArticles(
      {required int page, bool isInitialLoad = false}) async {
    if (isInitialLoad) {
      isLoadingInitial.value = true;
    } else {
      if (hasMoreData.value) {
        isLoadingMore.value = true;
      } else {
        return;
      }
    }

    final token = box.read('token');

    try {
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/article?page=$page'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        if (decodedResponse['status'] == true &&
            decodedResponse['data'] != null) {
          final paginationData = decodedResponse['data'];

          if (paginationData['data'] is List) {
            List<dynamic> fetchedArticlesRaw = paginationData['data'] ?? [];
            List<Map<String, dynamic>> fetchedArticles =
                List<Map<String, dynamic>>.from(fetchedArticlesRaw);
            if (isInitialLoad) {
              articles.clear();
            }
            articles.addAll(fetchedArticles);

            currentPage.value = paginationData['current_page'] ?? page;
            lastPage.value = paginationData['last_page'] ?? page;
            hasMoreData.value = currentPage.value < lastPage.value;
          } else {
            if (isInitialLoad) articles.clear();
            hasMoreData.value = false;
          }
        }
      } else {
        if (isInitialLoad) articles.clear();
        hasMoreData.value = false;
      }
    } catch (e) {
      if (isInitialLoad) articles.clear();
      hasMoreData.value = false;
    } finally {
      if (isInitialLoad) {
        isLoadingInitial.value = false;
      }
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshArticles() async {
    currentPage.value = 1;
    hasMoreData.value = true;
    await fetchArticles(page: 1, isInitialLoad: true);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }
}
