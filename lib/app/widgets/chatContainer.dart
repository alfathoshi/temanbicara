import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/detail_artikel/views/detail_artikel_view.dart';
import 'package:temanbicara/app/modules/room_chat/views/room_chat_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class Chatcontainer extends StatelessWidget {
  final String? image;
  final String? nama;
  final String? deskripsi;

  const Chatcontainer(
      {super.key,
    this.nama,
    this.deskripsi,this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       Navigator.push(context, MaterialPageRoute(builder: (context)=> RoomChatView(nama: nama,image: image,)));
      },
      child: Container(
        width: 393,
        height: 90,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border(
            bottom: BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.4))
          ),
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
                backgroundImage: AssetImage('assets/images/${image}.png'),
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
                      style: h7Regular.copyWith(color: Colors.grey.withOpacity(0.9)),
                      
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      
                    ),
                  ),
                ],
              ),
            ),
            Text("08.30",style: h7Regular.copyWith(color: Colors.grey.withOpacity(0.9)),)
          ],
        ),
      ),
    );
  }
}
