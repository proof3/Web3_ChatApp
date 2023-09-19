import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'metamask_provider.dart';
import 'contacts_menue.dart';
import 'conversation.dart';

void main() {
  runApp(
    const MaterialApp(home: MyApp())
  );
}

//current task: use menuemodel to keep track of conversation in conversation menue

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [
      ChatUsers(id: 0,name: "Jane Russel", messageText: "Awesome Setup", imageURL: "images/userImage1.jpeg", time: "Now"),
      ChatUsers(id: 1,name: "Glady's Murphy", messageText: "That's Great", imageURL: "images/userImage2.jpeg", time: "Yesterday"),
      ChatUsers(id: 2,name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "images/userImage3.jpeg", time: "31 Mar"),
      ChatUsers(id: 3,name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "images/userImage4.jpeg", time: "28 Mar"),
      ChatUsers(id: 4,name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "images/userImage5.jpeg", time: "23 Mar"),
      ChatUsers(id: 5,name: "Jacob Pena", messageText: "will update you in evening", imageURL: "images/userImage6.jpeg", time: "17 Mar"),
      ChatUsers(id: 6,name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "images/userImage7.jpeg", time: "24 Feb"),
      ChatUsers(id: 7,name: "John Wick", messageText: "How are you?", imageURL: "images/userImage8.jpeg", time: "18 Feb"),
    ];
    List<Message> messages = [
      Message(id: 0, message: 'Added iMessage shape bubbles', sender: true),
      Message(id: 1, message: 'Please try and give some feedback on it!', sender: true),
      Message(id: 2, message: 'Sure', sender: false),
      Message(id: 3, message: "I tried. It's awesome!!!", sender: false),
      Message(id: 4, message: "Thanks", sender: false)
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF7C90A0),
      body: ChangeNotifierProvider(
        create: (context) => MetaMaskProvider()..start,
        builder: (context, child) {

          return Center (
            child: Consumer<MetaMaskProvider>(
              builder: (context, provider, child) {
                late final String message;
                if (provider.isConnected && provider.isInOperatingChain) {
                  // Once user logged in start, display info here
                  // Start of with list view of all the people your chatting with
                  
                  return MultiProvider(
                    providers: [
                      ChangeNotifierProvider<MenueModel>(
                        create: (context) => MenueModel()..start(chatUsers),
                      ),
                      ChangeNotifierProxyProvider<MenueModel, ConversationModel>(
                        create: (context) => ConversationModel()..start(messages, chatUsers[0].name),
                        update: (context, menue, conversation) {
                          if (conversation == null) throw ArgumentError.notNull('conversation');
                          conversation.user = menue.selectedUserName;
                          return conversation;
                        },
                      ),
                    ],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Consumer<MenueModel>(
                            builder: (context, menue, child) {
                              return const ContactsMenue();
                            },
                          ),
                        ),
                        Expanded(
                          child: Consumer<ConversationModel>(
                            builder: (context, conversation, child) {
                              return const Conversation();
                            },
                          ),
                        ),
                      ],
                    ),
                  );

                }
                else if (provider.isConnected && !provider.isInOperatingChain) {
                  message = 'Wrong Chain. please connect to ${MetaMaskProvider.operatingChain}';
                }
                else if (provider.isEnabled) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Welcome to Chat app',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Roboto')
                        )
                      ),
                      MaterialButton(
                        onPressed:() => 
                          context.read<MetaMaskProvider>().connect(),
                        color: Colors.white,
                        padding: const EdgeInsets.all(0),
                        child: Row (
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                'https://i0.wp.com/kindalame.com/wp-content/uploads/2021/05/metamask-fox-wordmark-horizontal.png?fit=1549%2C480&ssl=1',
                                width: 250
                                )
                            ]
                        ),
                      ),
                    ],
                  );
                } else {
                  message = 'Please use Webs3 supported browser';
                }
                return Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                );
              },
            )
          );
        },
      )
    );
  }
}
