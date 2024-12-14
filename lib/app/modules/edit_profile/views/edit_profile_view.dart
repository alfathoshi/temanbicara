import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/date.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedDateOfBirth = '';
  String selectedCountry = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            title: Center(
                child: Text(
              'Edit Profile',
              style: h4Bold,
            )),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.8,
              // decoration: BoxDecoration(color: Colors.blue),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: border,
                            child: CircleAvatar(
                              radius: 58,
                              backgroundColor: whiteColor,
                              child: Image.asset(
                                'assets/images/profile.png',
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: whiteColor,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama',
                          style: textDescriptionSemiBold,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Email',
                          style: textDescriptionSemiBold,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Password',
                          style: textDescriptionSemiBold,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Tanggal Lahir',
                          style: textDescriptionSemiBold,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        date(),
                        SizedBox(
                          height: 16,
                        ),
                        // Text(
                        //   'Negara',
                        //   style: textDescriptionSemiBold,
                        // ),
                        SizedBox(
                          height: 8,
                        ),
                        // DropdownSearch<String>(
                        //   items: (filter, infiniteScrollProps) => [
                        //     'Indonesia',
                        //     'Singapore',
                        //     'Malaysia',
                        //     'Jepang',
                        //     'Korea'
                        //   ],
                        //   suffixProps: const DropdownSuffixProps(
                        //     dropdownButtonProps: DropdownButtonProps(
                        //       iconClosed: Icon(Icons.keyboard_arrow_down),
                        //       iconOpened: Icon(Icons.keyboard_arrow_up),
                        //     ),
                        //   ),
                        //   decoratorProps: DropDownDecoratorProps(
                        //     decoration: InputDecoration(
                        //         contentPadding: const EdgeInsets.all(15),
                        //         filled: true,
                        //         fillColor: Colors.white,
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(16),
                        //           borderSide: const BorderSide(
                        //             color: Colors.black26,
                        //             width: 2,
                        //           ),
                        //         ),
                        //         hintText: 'pilih negara',
                        //         hintStyle: textFieldStyle),
                        //   ),
                        //   popupProps: PopupProps.menu(
                        //     itemBuilder:
                        //         (context, item, isDisabled, isSelected) {
                        //       return Padding(
                        //         padding: const EdgeInsets.all(15),
                        //         child: Text(
                        //           item,
                        //           style: textFieldStyle,
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       );
                        //     },
                        //     constraints: const BoxConstraints(maxHeight: 160),
                        //     menuProps: const MenuProps(
                        //       margin: EdgeInsets.only(top: 12),
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(12))),
                        //     ),
                        //   ),
                        //   onChanged: (country) {
                        //     controller.setCountry(country ?? '');
                        //   },
                        //   selectedItem: controller.selectedCountry.value,
                        // ),
                      ],
                    ),
                    MyButton(
                      get: () {
                        Get.toNamed(Routes.PROFILE);
                      },
                      color: primaryColor,
                      text: 'Simpan',
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
