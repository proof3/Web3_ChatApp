import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenueModel extends ChangeNotifier {
  
  final List<ChatUsers> chats = [];
  late String _selectedUser;
  late int _selectedUserId;
  
  String get selectedUserName => _selectedUser;
  int get selectedUserId => _selectedUserId;

  set selectedUserId(user) {
    _selectedUserId = user;
    notifyListeners();
  }

  set selectedUserName(user) {
    _selectedUser = user;
    notifyListeners();
  }
    
  start(List<ChatUsers> chatList) {
    chats.addAll(chatList);
    _selectedUser = chatList[0].name;
    _selectedUserId = chatList[0].id;
  }
}

class ChatUsers{
  int id;
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({required this.id,required this.name, required this.messageText, required this.imageURL,required this.time});
}

class ContactsMenue extends StatelessWidget {
  const ContactsMenue({super.key});

  @override
  Widget build(BuildContext context) {

    var menue = context.watch<MenueModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: ListView.builder(
        itemCount: menue.chats.length,
        itemBuilder: (context, index) => ListTile(
          leading: const CircleAvatar(child: Text('A')),
          title: Text(menue.chats[index].name),
          subtitle: Text(menue.chats[index].messageText),
          onTap: () {
            menue.selectedUserName = menue.chats[index].name;
            menue.selectedUserId = menue.chats[index].id;
          },
        ),
      )
    );
  }
}