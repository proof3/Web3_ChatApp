import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'metamask_provider.dart';

void main() {
  runApp(
    const MaterialApp(home: MyApp())
  );
}

class MyApp extends StatelessWidget {
  static const List<String> contacts = ['Ryan the Retarded',"Dora the Derranged","Harry Shithouse"];
  const MyApp({Key? key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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

                  message = 'Connected';
                  return ListView(
                    padding: const EdgeInsets.all(8),
                    children: contacts.map((contacts){
                      return SizedBox(
                          height: 50,
                          width: 45,
                          //color: const Color(0xFFF4F9E9),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: ()
                              {
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                  Screen2(name: contacts)));
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.fromLTRB(175, 0, 175, 0),
                                backgroundColor: const Color(0xFFF4F9E9)
                              ),
                              child: Text(
                                contacts,
                                style: const TextStyle(
                                  color: Color(0xFF153243),
                                )
                              )
                            )
                          ),
                      );
                    }).toList(),
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
                          style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Roboto'),
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

class Screen2 extends StatelessWidget {
  const Screen2({super.key, required this.name});
  final String name;

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with $name"),
        backgroundColor: const Color(0xFF7C90A0),
      ),
    );
  }
}