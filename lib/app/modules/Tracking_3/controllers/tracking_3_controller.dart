import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class Tracking3Controller extends GetxController {
  var selectedNumber = 0.obs;
  var activeIndex = Rxn<int>();

  final box = GetStorage();

  void selectNumber(int number) {
    selectedNumber.value = number;
    activeIndex.value = selectedNumber.value;
    box.write('stress_level', selectedNumber.value);
  }

  Widget explanationText() {
    // if (activeIndex.value == 0 || activeIndex.value == null) {
    //   return Padding(
    //     padding: const EdgeInsets.all(30.0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Icon(
    //           Icons.warning_amber_rounded,
    //           color: Colors.orange,
    //         ),
    //         Text(
    //           'Silahkan pilih salah satu',
    //           style: h5Bold.copyWith(color: Colors.orange),
    //         )
    //       ],
    //     ),
    //   ); } else
    if (activeIndex.value == 1) {
      return Text('Apakah ada hal yang mengganggu pikiranmu?',
          style: h6Bold.copyWith(color: greyColor));
    } else if (activeIndex.value == 2) {
      return Text('Coba cari suasana baru',
          style: h6Bold.copyWith(color: greyColor));
    } else if (activeIndex.value == 3) {
      return Text('Kamu sepertinya cukup stress',
          style: h6Bold.copyWith(color: greyColor));
    } else if (activeIndex.value == 4) {
      return Text('Kamu bisa berbagi kereshanmu disini',
          style: h6Bold.copyWith(color: greyColor));
    } else if (activeIndex.value == 5) {
      return Text('Apakah kamu perlu bantuan ahli?',
          style: h6Bold.copyWith(color: greyColor));
    }
    return const Text('');
  }
}
