import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/chat/controllers/chat_controller.dart';
import 'package:temanbicara/app/modules/detail_artikel/views/detail_artikel_view.dart';
import 'package:temanbicara/app/modules/room_chat/views/room_chat_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class Chatcontainer extends StatelessWidget {
  final int id;
  final String time;
  final String? image;
  final String? nama;
  final String? deskripsi;

  const Chatcontainer({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.image,
    required this.id,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CHAT_ROOM,
            arguments: {'name': nama, 'counselor_id': id});
      },
      child: Container(
        width: 393,
        height: 90,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border(
              bottom:
                  BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.4))),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: CircleAvatar(
                radius: 30,
                child: Image.asset(
                  'assets/images/${image}.png',
                  scale: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 13, 17, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nama!,
                    style: h6Bold,
                  ),
                  Container(
                    width: 210,
                    child: Text(
                      deskripsi!,
                      style: h7Regular.copyWith(
                          color: Colors.grey.withOpacity(0.9)),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: h7Regular.copyWith(color: Colors.grey.withOpacity(0.9)),
            )
          ],
        ),
      ),
    );
  }
}
