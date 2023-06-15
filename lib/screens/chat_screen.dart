import 'package:chat_app/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String messageText = '';
  User? loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // print('welcome')
        loggedInUser = user;
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }
  void messageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        title: Text('Chat'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // getMessages();
                messageStream();
              },
              icon: Icon(Icons.close))
        ],
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshots) {
                final messages = snapshots.data?.docs;
                List<Text> messageWidgets = [];
                for (var message in messages!) {
                  final messageText = message.get('text');
                  final messageSender = message.get('sender');
                  final messagewidget =
                      Text('$messageText from $messageSender');
                  messageWidgets.add(messagewidget);
                }
                return Column(
                  children: messageWidgets,
                );
              }),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) {
                      messageText = value;
                      print(messageText);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type your message here....'),
                  ),
                )),
                // CustomRoundedButtom(
                //   onPressed: () {},
                //   title: 'send',
                // )
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser?.email
                        });
                      },
                      child: Text('Send')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
