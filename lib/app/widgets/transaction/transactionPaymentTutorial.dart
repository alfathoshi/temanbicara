import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

class TransactionPaymentTutorial extends StatelessWidget {
  final String method;
  TransactionPaymentTutorial({super.key, required this.method});

  final controller = Get.put(TransactionTutorialController());

  final Map<String, List<String>> tutorialStepsMap = {
    "ATM": [
      "1. Masukkan kartu ATM dan PIN",
      "2. Pilih menu “Bayar/Beli”",
      "3. Pilih menu “Lainnya”, hingga menemukan menu “Multipayment”",
      "4. Masukkan Kode",
      "5. Masukkan “Nomor Virtual Account”",
      "6. Masukkan Angka “1” untuk memilih tagihan, lalu pilih tombol Ya",
      "7. Konfirmasi pembayaran dengan pilih tombol Ya",
      "8. Simpan struk sebagai bukti pembayaran",
    ],
    "Mobile Banking": [
      "1. Login ke aplikasi Mobile Banking",
      "2. Pilih menu Pembayaran",
      "3. Pilih Virtual Account",
      "4. Masukkan nomor VA",
      "5. Pastikan nama dan jumlah tagihan sesuai",
      "6. Konfirmasi dan masukkan PIN",
      "7. Tunggu notifikasi transaksi berhasil",
    ],
    "Internet Banking": [
      "1. Buka website resmi bank dan login",
      "2. Pilih menu Pembayaran > Virtual Account",
      "3. Masukkan nomor Virtual Account",
      "4. Cek detail tagihan",
      "5. Konfirmasi pembayaran dengan token",
      "6. Simpan bukti transfer",
    ],
    "Mini Market": [
      "1. Kunjungi kasir di minimarket (Alfamart/Indomaret)",
      "2. Sampaikan ingin membayar Virtual Account",
      "3. Berikan nomor Virtual Account kepada kasir",
      "4. Kasir akan memproses dan memberikan total pembayaran",
      "5. Bayar sesuai nominal",
      "6. Simpan struk sebagai bukti pembayaran",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> tutorialSteps =
        tutorialStepsMap[method] ?? ["Tidak ada panduan untuk metode ini."];

    return Obx(() => GestureDetector(
          onTap: controller.toggleExpanded,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 33, bottom: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("How to pay via $method?", style: h7Bold),
                    const Spacer(),
                    sbX12,
                    Icon(
                      controller.isExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.chevron_right_rounded,
                      size: 20,
                    ),
                  ],
                ),
                if (controller.isExpanded.value) ...[
                  const SizedBox(height: 16),
                  ...tutorialSteps.map(
                    (step) {
                      final numberMatch = RegExp(r'^(\d+)\.').firstMatch(step);
                      final number = numberMatch?.group(0) ?? '';
                      final text = step.replaceFirst(RegExp(r'^\d+\.\s*'), '');

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              number,
                              style: h6SemiBold.copyWith(height: 1.5),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                text,
                                style: h6SemiBold.copyWith(height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ));
  }
}

class TransactionTutorialController extends GetxController {
  var isExpanded = true.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}
