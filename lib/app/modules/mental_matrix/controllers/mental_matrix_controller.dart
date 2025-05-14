import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/modules/report/controllers/report_controller.dart';
import '../../../data/report_model.dart';
import 'package:get/get.dart';

class MentalMatrixController extends GetxController {
  var report = Rxn<ReportModel>();
  var isLoading = false.obs;
  final box = GetStorage();
  var title = ''.obs;
  var detail = ''.obs;
  var matrixValue = ''.obs;
  var isTrackingFilled = false.obs;
  final List<String> emotions = [
    'Depressed',
    'Sad',
    'Neutral',
    'Happy',
    'Cheerful'
  ];

  final List<String> sleepQuality = [
    '> 7 hours',
    '5-6 hours',
    '4-5 hours',
    '3-4 hours',
    '< 3 hours'
  ];

  final List<String> activity = [
    '< 500 steps',
    '500-1k steps',
    '1k-3k steps',
    '3k-5k steps',
    '> 6k steps'
  ];

  final List<String> screenTime = [
    '< 1 hours',
    '1-2 hours',
    '2-3 hours',
    '3-4 hours',
    '> 5 hours'
  ];

  // Future<void> getReport() async {
  //   try {
  //     isLoading.value = true;
  //     final userId = box.read('id');
  //     final token = box.read('token');

  //     var response = await http.post(
  //       Uri.parse('${Config.apiEndPoint}/report'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({
  //         'date_request': "2025-05-08",
  //       }),
  //     );

  //     var data = json.decode(response.body);
  //     // print('response body: ${response.body}');

  //     if (response.statusCode == 200 &&
  //         data['status'] == true &&
  //         data['data'] != null) {
  //       report.value = ReportModel.fromJson(data['data'][0]);
  //     } else {
  //       Get.snackbar('Error', data['message'] ?? 'Gagal Menyiapkan Report',
  //           backgroundColor: Colors.red.withValues(alpha: 0.6),
  //           colorText: whiteColor);
  //     }
  //   } catch (e) {
  //     print('Error getReport: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  String getIndexedImage({
    required String? value,
    required List<String> referenceList,
    required String prefix,
  }) {
    if (value == null) return '${prefix}1.png';
    final index = referenceList.indexOf(value.trim());
    if (index != -1) {
      return '$prefix${index + 1}.png';
    }
    return '${prefix}1.png';
  }

  @override
  void onInit() {
    super.onInit();
    // getReport();
    ReportController().getMatrix();
  }
}
