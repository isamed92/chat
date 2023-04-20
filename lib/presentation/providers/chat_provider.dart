import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();

  List<Message> messages = [
    Message(text: 'Hola amor', fromWho: FromWho.mine),
    Message(text: 'ya regresaste del trabajo?', fromWho: FromWho.mine),
  ];

  Future<void> sendMessage(String msg) async {
    if (msg.isEmpty) return;
    final newMessage = Message(text: msg, fromWho: FromWho.mine);

    messages.add(newMessage);
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
