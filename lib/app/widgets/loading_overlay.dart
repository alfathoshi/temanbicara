import 'dart:ui';
import 'package:flutter/material.dart';
import '../themes/colors.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    // Kalo nggak loading, tampilin widget kosong
    if (!isLoading) {
      return const SizedBox.shrink();
    }

    // Kalo loading, tampilin overlay-nya
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
