import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/colors.dart';

class CustomSnackbar {
  static void showSnackbar(
      {BuildContext? context,
      required String title,
      required String message,
      required bool status}) {
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox.shrink(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      backgroundColor: Colors.white,
      borderRadius: 16,
      boxShadows: [
        BoxShadow(
          color: const Color(0xff4B4B4B).withValues(alpha: 0.15),
          blurRadius: 16,
          offset: const Offset(0, 2),
        ),
      ],
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: status
                  ? Colors.green.withValues(alpha: 0.2)
                  : error.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                    status ? Icons.check_circle_outline : Icons.cancel_outlined,
                    color: status ? Colors.green : error,
                    size: 24),
                const SizedBox(width: 8),
                Text(
                  status ? 'Success' : 'Failed',
                  style: TextStyle(
                    color: status ? Colors.green : error,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
