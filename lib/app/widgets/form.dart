import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class form extends StatelessWidget {
  form({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController namePanggilanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama',
          style: textDescriptionSemiBold,
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Masukan Nama Lengkap',
            hintStyle: textFieldStyle,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.black26,
                  width: 2,
                )),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Nama Panggilan',
          style: textDescriptionSemiBold,
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: namePanggilanController,
          decoration: InputDecoration(
            hintText: 'Masukan Nama Panggilan',
            hintStyle: textFieldStyle,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.black26,
                  width: 2,
                )),
          ),
        ),
      ],
    );
  }
}
