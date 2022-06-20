import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';


class Message extends StatefulWidget{
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState(){
    super.initState();
// トークン取得
    _firebaseMessaging.getToken().then((token) {
      print("$token");
    });
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title:Text('Firebase Messaging'),
        ),
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Text('FCMテスト'),
            ],
          )
        ),
      );
    }
  }
