import 'package:flutter/material.dart';

class ChatUsers{
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({required this.name, required this.messageText, required this.imageURL,required this.time});
}

class ContactsMenue extends StatelessWidget {
  const ContactsMenue({super.key, required this.users});
  final List<ChatUsers> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile Sample')),
      body: ListView(
        children: users.map((users) {
          String name = users.name;
          return ListTile(
            leading: const CircleAvatar(child: Text('A')),
            title: Text(name),
            subtitle: const Text('Supporting text'),
            trailing: const Icon(Icons.favorite_rounded),
          ); 
        }).toList()
      ),
    );
  }
}