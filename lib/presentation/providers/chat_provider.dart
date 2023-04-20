import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();

  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messages = [];
  Future<void> herReply() async {
    final herMsg = await getYesNoAnswer.getAnswer();
    messages.add(herMsg);

    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> sendMessage(String msg) async {
    if (msg.isEmpty) return;
    final newMessage = Message(text: msg, fromWho: FromWho.mine);

    messages.add(newMessage);

    if (msg.endsWith('?')) {
      await herReply();
    }
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
