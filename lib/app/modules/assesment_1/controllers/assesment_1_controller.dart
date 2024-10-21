import 'package:get/get.dart';

enum Gender { none, male, female }

class Assesment1Controller extends GetxController {
  var selectedGender = Gender.none.obs;
  void toggleGender(Gender gender) {
    selectedGender.value = gender;
  }

  var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  var selectedDateOfBirth = ''.obs;
  void setDateOfBirth(String date) {
    selectedDateOfBirth.value = date;
  }

  var selectedMBTI = ''.obs;
  void setMBTI(String mbti) {
    selectedMBTI.value = mbti;
  }

  var favoriteTopics = <String>[].obs;
  void toggleFavoriteTopic(String topic) {
    if (favoriteTopics.contains(topic)) {
      favoriteTopics.remove(topic);
    } else {
      favoriteTopics.add(topic);
    }
  }

  var isSportTap = false.obs;
  var isArtTap = false.obs;
  var isPoliticsTap = false.obs;
  var isAnxietyTap = false.obs;
  var isTechTap = false.obs;
  var isInnovationTap = false.obs;
  var isLainnyaTap = false.obs;
  void toggleTopis(String topic) {
    switch (topic) {
      case 'Sport':
        isSportTap.value = !isSportTap.value;
        break;
      case 'Art':
        isArtTap.value = !isArtTap.value;
        break;
      case 'Politics':
        isPoliticsTap.value = !isPoliticsTap.value;
        break;
      case 'Anxiety':
        isAnxietyTap.value = !isAnxietyTap.value;
        break;
      case 'Tech':
        isTechTap.value = !isTechTap.value;
        break;
      case 'Innovation':
        isInnovationTap.value = !isInnovationTap.value;
        break;
      case 'Lainnya':
        isLainnyaTap.value = !isLainnyaTap.value;
        break;
    }
  }

  // Future<void> saveData(String name, String gender, String dateOfBirth, String mbti, List<String> favoriteTopics) async {
  //   CollectionReference assessments = FirebaseFirestore.instance.collection('assessments');

  //   try {
  //     await assessments.add({
  //       'name': name,
  //       'gender': gender,
  //       'date_of_birth': dateOfBirth,
  //       'mbti': mbti,
  //       'favorite_topics': favoriteTopics,
  //     });
  //     Get.snackbar('Success', 'Data saved successfully!');
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to save data: $e');
  //   }
  // }
}
