import 'package:get/get.dart';

class ConsultScheduleController extends GetxController {
  final selectedDate = DateTime.now().obs;
  final selectedSchedule = Rx<Map<String, dynamic>>({});

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    resetSelectedSchedule();
  }

  void resetSelectedSchedule() {
    selectedSchedule.value = {};
  }

  void updateSelectedSchedule(Map<String, dynamic> schedule) {
    selectedSchedule.value = schedule;
  }

  DateTime get currentDate => selectedDate.value;
}
