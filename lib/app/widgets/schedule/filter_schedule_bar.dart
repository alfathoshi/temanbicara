import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class FilterBarWidget extends StatelessWidget {
  final List<String> selectedFilters;
  final VoidCallback onClear;

  const FilterBarWidget({
    super.key,
    required this.selectedFilters,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Filtered by: ${selectedFilters.join(', ')}",
              style: h7SemiBold.copyWith(color: primaryColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: onClear,
            child: Container(
              width: 69,
              height: 23,
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: grey4Color),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  "Clear",
                  style: h7SemiBold.copyWith(color: error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
