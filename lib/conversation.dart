import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

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
  final int id;
  final String user;
  final List<Message>  messages;
  const Conversation({super.key, required this.id, required this.user, required this.messages});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: messages.map((message) {
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
            onSend: (_) => print(_),
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