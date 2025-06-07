import 'package:get/get.dart';

import '../../../widgets/consult/format_date.dart';

class JournalDetailController extends GetxController {
  final RxString journalId = ''.obs;
  final RxString title = ''.obs;
  final RxString body = ''.obs;
  final RxString imageUrl = ''.obs;
  final RxString createdAtRaw =
      ''.obs; 
  final RxString displayDate =
      ''.obs; 

  
  String _formatDateForDisplay(DateTime dateTime) {
    
    return formatDate(dateTime);
  }

  
  void _processArguments() {
    final arguments = Get.arguments as Map<String, dynamic>?; 

    if (arguments != null) {
      journalId.value = arguments['journal_id']?.toString() ?? '';
      title.value = arguments['title']?.toString() ?? 'Titile not found';
      body.value =
          arguments['body']?.toString() ?? 'Content not found';
      imageUrl.value = arguments['image_url']?.toString() ?? '';
      createdAtRaw.value = arguments['created_at']?.toString() ?? '';

      if (createdAtRaw.value.isNotEmpty) {
        try {
          DateTime parsedDate = DateTime.parse(createdAtRaw.value);
          displayDate.value = _formatDateForDisplay(parsedDate);
        } catch (e) {
          displayDate.value = 'Format Tanggal Salah';
          
        }
      } else {
        displayDate.value = 'No date';
      }
    } else {
    
      title.value = 'Error to load journal';
      body.value = 'Can not load journal';
      displayDate.value = '';
    
    }
  }

  @override
  void onInit() {
    super.onInit();
    _processArguments(); 
  }
}
