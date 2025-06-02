import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

class ChatbotRoomController extends GetxController {
  final Gemini gemini = Gemini.instance;
  var messages = <types.Message>[].obs;
  late StreamSubscription subscription;
  final user = const types.User(
    id: '1',
    firstName: 'Bintang',
  );

  final tebi = const types.User(
    id: '2',
    firstName: 'Tebi',
  );

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void addMessage(types.Message message) {
    messages.insert(0, message);
  }

  void updateMessage(String messageId, String newText) {
    final index = messages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      messages[index] = types.TextMessage(
        author: tebi,
        createdAt: messages[index].createdAt,
        id: messageId,
        text: newText,
      );
    }
  }

  Future<void> handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    addMessage(textMessage);

    try {
      String question = message.text;
      List<String> responseParts = [];

      final placeholderMessage = types.TextMessage(
        author: tebi,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: '. . .',
      );
      addMessage(placeholderMessage);

      final botMessageId = placeholderMessage.id;

      subscription = gemini.streamGenerateContent(question).listen(
        (event) {
          for (var part in event.content?.parts ?? []) {
            if (part is TextPart && part.text.trim().isNotEmpty) {
              responseParts.add(part.text.trim());
            }
          }
        },
        onDone: () {
          updateMessage(botMessageId, responseParts.join(' '));
        },
        onError: (error) {
          updateMessage(botMessageId, 'Something went wrong!');
        },
      );
    } catch (e) {
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "Generating Content Failed!",
        status: false,
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    messages.close();
  }
}
