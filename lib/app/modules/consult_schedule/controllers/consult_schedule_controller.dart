import 'package:get/get.dart';

class ConsultScheduleController extends GetxController {
  final selectedDate = DateTime.now().obs;
  final selectedSchedule = Rx<Map<String, dynamic>>({});

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    print(selectedDate.value);
  }

  void updateSelectedSchedule(Map<String, dynamic> schedule) {
    selectedSchedule.value = schedule;
    print(selectedSchedule.value);
  }

  DateTime get currentDate => selectedDate.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
