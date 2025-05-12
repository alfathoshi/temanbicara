import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/consult_pending.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/consult/order_details.dart';
import 'package:temanbicara/app/widgets/transaction/idr_formatter.dart';

class ConsultPendingCard extends StatelessWidget {
  final ConsultPending consultPending;
  const ConsultPendingCard({
    super.key,
    required this.consultPending,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          border: Border.all(color: grey4Color),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 26, 16, 20),
              child: Row(
                children: [
                  Container(
                    width: 68,
                    height: 77,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/Hafid.jpg',
                        scale: 1.5,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  sbX12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth - 240,
                        child: Text(
                          consultPending.nama,
                          style: h4Bold,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth - 240,
                        child: Text(
                          consultPending.expertises,
                          style: h7Regular.copyWith(color: grey2Color),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      sby12,
                      Text(
                        consultPending.durasi,
                        style: h6Bold,
                      ),
                      Text(
                        "${consultPending.tanggal} ${consultPending.waktu}",
                        style: h6Bold,
                      ),
                    ],
                  ),
                  sbx8,
                  Container(
                    height: 77,
                    width: 1,
                    color: grey2Color,
                  ),
                  sbX12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pay\nWithin",
                        style: h7Regular.copyWith(color: grey2Color),
                      ),
                      sby5,
                      Text(
                        consultPending.tanggalTenggat,
                        style: h6Bold.copyWith(
                          color: const Color(0xFFFC7070),
                        ),
                      ),
                      Text(
                        consultPending.waktuTenggat,
                        style: h6Bold.copyWith(
                          color: const Color(0xFFFC7070),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            sby16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Method",
                        style: h6SemiBold.copyWith(color: grey2Color),
                      ),
                      Text(
                        consultPending.metodePembayaran,
                        style: h6Bold,
                      ),
                    ],
                  ),
                  sby8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: h6SemiBold.copyWith(color: grey2Color),
                      ),
                      Text(
                        CurrencyFormat.convertToIdr(
                          int.parse(consultPending.totalHarga) + 15000 + 1000,
                          2,
                        ),
                        style: h6Bold,
                      ),
                    ],
                  ),
                  sby16,
                  MyButtonCustom(
                    get: () {
                      Get.to(
                        OrderDetails(
                          consultPending: consultPending,
                        ),
                      );
                    },
                    foreColor: whiteColor,
                    backColor: primaryColor,
                    height: 40,
                    text: "Complete Payment",
                    width: double.infinity,
                    style: h5Bold.copyWith(color: whiteColor),
                  ),
                  sby8,
                  MyButtonOutlinedCustom(
                    get: () {},
                    foreColor: const Color(0xFFFC7070),
                    backColor: whiteColor,
                    height: 40,
                    text: "Cancel Consultation",
                    width: double.infinity,
                    style: h5Bold.copyWith(color: error),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
