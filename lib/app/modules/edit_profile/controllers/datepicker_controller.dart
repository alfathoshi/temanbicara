import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DatePickerController extends GetxController {
 GetStorage box = GetStorage();
 var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);;
  }
}
