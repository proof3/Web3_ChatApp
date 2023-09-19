import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:provider/provider.dart';

class ConversationModel extends ChangeNotifier {
  final List<Message> _messages = [];
  late String _user;

  List<Message> get messages => _messages;

  set messages (msgs) {
    _messages.addAll(msgs);
    notifyListeners();
  }

  String get user => _user;

  set user(changedUser) {
    _user = changedUser;
    notifyListeners();
  }

  start(msgs, changedUser) {
    messages = msgs;
    user = changedUser;
  }

  add(msg) {
    _messages.add(Message(id: _messages.length, message: msg, sender: true));
    notifyListeners();
  }

}

class Message {
  int id;
  String message;
  bool sender;
  //to be implemented later when integrating into database
  // String from;
  // String to;
  Message({required this.id, required this.message, required this.sender});
}

class Conversation extends StatelessWidget {
  const Conversation({super.key});

  @override
  Widget build(context) {

    var conversations = context.watch<ConversationModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(conversations.user),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: conversations._messages.map((message) {
                if (message.sender) {
                  return BubbleSpecialThree(
                    text: message.message,
                    color: const Color(0xFF1B97F3),
                    tail: false,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),
                  );
                }
                else {
                  return BubbleSpecialThree(
                    text: message.message,
                    color: const Color(0xFFE8E8EE),
                    tail: false,
                    isSender: false,
                  );
                }
              }).toList()
            )
          ),
          MessageBar(
            onSend: (String msg) => conversations.add(msg),
            actions: [
              InkWell(
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}