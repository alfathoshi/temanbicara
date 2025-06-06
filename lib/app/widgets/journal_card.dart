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
        left: 8,
        right: 8,
      ),
      child: GestureDetector(
        onTap: getJournal,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: border,
            ),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox.shrink();
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                child: Text(
                  title,
                  style: h4SemiBold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  body,
                  style: h5Regular,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: h7Regular,
                    ),
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
