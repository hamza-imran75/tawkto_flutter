import 'package:flutter/material.dart';
import 'package:tawkto_flutter/tawkto_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TawkTo Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'TawkTo Flutter',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: const TawkNew(),
      ),
    );
  }
}

class TawkNew extends StatelessWidget {
  const TawkNew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TawkToWidget(
      directChatLink: 'YOUR_DIRECT_CHAT_LINKs',
      visitor: TawkToVisitor(
        name: 'Hamza Imran',
        email: 'hamzaimran43@gmail.com',
      ),
      onChatMessageAgent: (msg) {
        print("MESSAGE_FROM_AGENT: $msg");
      },
    );
  }
}
