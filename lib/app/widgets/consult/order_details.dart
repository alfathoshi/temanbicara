import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/consult_pending.dart';
import 'package:temanbicara/app/modules/booking_history/controllers/booking_history_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/idr_formatter.dart';
import 'package:temanbicara/app/widgets/transaction/transaction_payment_tutorial.dart';
import 'package:temanbicara/app/widgets/transaction/transaction_va_number.dart';

class OrderDetails extends StatelessWidget {
  final ConsultPending consultPending;
  const OrderDetails({super.key, required this.consultPending});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingHistoryController());

    final Map<String, String> paymentLogos = {
      "BCA": 'assets/images/bcaLogo.png',
      "BNI": 'assets/images/bniLogo.png',
      "MANDIRI": 'assets/images/mandiriLogo.png',
      "CIMBNIAGA": 'assets/images/cimbNiagaLogo.png',
    };
    final Map<String, String> paymentName = {
      "BCA": 'BCA',
      "BNI": 'BNI',
      "MANDIRI": 'MANDIRI',
      "CIMBNIAGA": 'CIMBNIAGA',
    };
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        title: Text(
          'Order Details',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.checkPaymentStatus(consultPending.transactionId);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  border: const Border(
                    bottom: BorderSide(
                      color: grey4Color,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
                  child: Row(
                    children: [
                      Container(
                        width: 68,
                        height: 85,
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
                          Text(
                            consultPending.nama,
                            style: h4Bold,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          sby12,
                          // Text(
                          //   "dummy",
                          //   style: h7Regular.copyWith(
                          //     color: grey2Color,
                          //   ),
                          // ),
                          sby5,
                          Text(
                            consultPending.durasi,
                            style: h7SemiBold,
                          ),
                          sby5,
                          Text(
                            "${consultPending.tanggal} ${consultPending.waktuMulai}",
                            style: h7SemiBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              sby12,
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: grey4Color,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transaction Details",
                        style: h4Bold,
                      ),
                      sby16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Consultation Price",
                            style: h6SemiBold,
                          ),
                          Text(
                            CurrencyFormat.convertToIdr(
                                int.parse(consultPending.totalHarga), 2),
                            style: h6SemiBold,
                          )
                        ],
                      ),
                      sby8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Application Tax.",
                            style: h6SemiBold,
                          ),
                          Text(
                            CurrencyFormat.convertToIdr(15000, 2),
                            style: h6SemiBold,
                          )
                        ],
                      ),
                      sby8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Administration Tax.",
                            style: h6SemiBold,
                          ),
                          Text(
                            CurrencyFormat.convertToIdr(1000, 2),
                            style: h6SemiBold,
                          )
                        ],
                      ),
                      sby16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: h6Bold,
                          ),
                          Text(
                            CurrencyFormat.convertToIdr(
                              int.parse(consultPending.totalHarga) +
                                  15000 +
                                  1000,
                              2,
                            ),
                            style: h6Bold,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              sby12,
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: grey4Color,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Metode Pembayaran",
                        style: h4Bold,
                      ),
                      sby16,
                      Row(
                        children: [
                          Image.asset(
                            paymentLogos[consultPending.bank]!,
                            scale: 2,
                          ),
                          sbx8,
                          Text(
                            paymentName[consultPending.bank]!,
                            style: h4Bold,
                          ),
                        ],
                      ),
                      sby16,
                      TransactionVaNumber(vaNumber: consultPending.vaNumber),
                    ],
                  ),
                ),
              ),
              sby12,
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: grey4Color,
                  ),
                ),
                child: TransactionPaymentTutorial(method: "Mobile Banking"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
