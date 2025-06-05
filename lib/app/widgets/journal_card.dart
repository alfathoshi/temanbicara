// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

class JournalCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final String image;
  final Function()? getDelete;
  final Function()? getJournal;

  const JournalCard({
    super.key,
    required this.title,
    required this.body,
    required this.date,
    this.getDelete,
    required this.getJournal,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: GestureDetector(
        onTap: getJournal,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: border,
            ),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      image,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator(color: primaryColor));
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  title,
                  style: h4SemiBold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  body,
                  style: h5Regular,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: h7Regular,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            getDelete?.call();
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 24,
                            color: Colors.red,
                          ),
                        ),
                        sbX12,
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
