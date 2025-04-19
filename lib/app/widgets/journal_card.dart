// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/spaces.dart';

import '../themes/colors.dart';
import '../themes/fonts.dart';

class JournalCard extends StatelessWidget {
  final String title;
  final String body;
  final String type;
  final String date;
  final Color typeColor;
  final String image;
  final Function()? getDelete;
  final Function()? getEdit;

  const JournalCard({
    Key? key,
    required this.title,
    required this.body,
    required this.type,
    required this.date,
    this.getDelete,
    this.getEdit,
    required this.typeColor,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Text('Failed to load image');
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: h6SemiBold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                body,
                style: h7Regular,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 70,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: typeColor,
                    ),
                    child: Center(
                      child: Text(
                        type,
                        style: h7SemiBold.copyWith(
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
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
                      TextButton(
                          style: ButtonStyle(
                            minimumSize: WidgetStatePropertyAll(Size(8, 8)),
                            backgroundColor:
                                WidgetStatePropertyAll(primaryColor),
                          ),
                          onPressed: () {
                            getEdit?.call();
                          },
                          child: Text(
                            'Edit',
                            style: h7SemiBold.copyWith(
                              color: whiteColor,
                            ),
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
