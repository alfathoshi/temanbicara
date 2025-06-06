// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/data/booking_pending.dart';
import 'package:temanbicara/app/modules/booking_history/controllers/booking_history_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/consult/order_details.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';
import 'package:temanbicara/app/widgets/transaction/idr_formatter.dart';
import 'package:http/http.dart' as http;

class BookingPendingCard extends StatelessWidget {
  final BookingPending bookingPending;
  const BookingPendingCard({
    super.key,
    required this.bookingPending,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CancelBookingController());
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
                      child: Image.network(
                        bookingPending.profileUrl,
                        fit: BoxFit.cover,
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
                          bookingPending.nama,
                          style: h4Bold,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth - 240,
                        child: Text(
                          bookingPending.expertises,
                          style: h7Regular.copyWith(color: grey2Color),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      sby12,
                      Text(
                        bookingPending.durasi,
                        style: h6Bold,
                      ),
                      Text(
                        "${bookingPending.tanggal} ${bookingPending.waktuMulai}",
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
                        bookingPending.tanggalTenggat,
                        style: h6Bold.copyWith(
                          color: const Color(0xFFFC7070),
                        ),
                      ),
                      Text(
                        bookingPending.waktuTenggat,
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
                        bookingPending.metodePembayaran,
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
                          int.parse(bookingPending.totalHarga) + 15000 + 1000,
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
                          bookingPending: bookingPending,
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
                    get: () {
                      showCancelConfirmation(context, () async {
                        showDialog(
                          context: Get.context!,
                          barrierDismissible: false,
                          builder: (_) => Center(
                            child:
                                CircularProgressIndicator(color: primaryColor),
                          ),
                        );

                        final success = await controller.cancelBooking(
                          bookingPending.consultationID,
                        );

                        Navigator.of(Get.context!).pop();

                        if (success) {
                          final pendingController =
                              Get.find<BookingHistoryController>();
                          await pendingController.fetchData();
                        }
                      });
                    },
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

class CancelBookingController extends GetxController {
  var isCancelling = false.obs;

  Future<bool> cancelBooking(int uuid) async {
    try {
      final token = GetStorage().read('token');

      final response = await http.patch(
        Uri.parse('${Config.apiEndPoint}/consultation/$uuid/cancel'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final statusCode = response.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        CustomSnackbar.showSnackbar(
          title: "Success!",
          message: "Consultation Cancelled!",
          status: true,
        );
        return true;
      } else {
        CustomSnackbar.showSnackbar(
          title: "Oops!",
          message: "Cancelling Consultation Failed!",
          status: false,
        );
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

void showCancelConfirmation(BuildContext context, VoidCallback onConfirm) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: whiteColor,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Are You Sure?',
            style: h3Bold,
            textAlign: TextAlign.center,
          ),
          sby12,
          Image.asset(
            "assets/images/transaksi-gagal.png",
            scale: 9,
          ),
          Text(
            'This Action Will Cancel your Consultation!',
            style: h6SemiBold.copyWith(color: error),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          MyButton(
            get: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            color: primaryColor,
            text: "Yes, Cancel",
          ),
          sby12,
        ],
      ),
    ),
  );
}
