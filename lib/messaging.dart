import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
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
    _firebaseMessaging.getToken().then((String? token) {
      print("$token");
    });
// アンドロイド通知設定（フォアグラウンド）
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print('フォアグラウンドでメッセージを受け取りました');
      
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;


      if(notification != null && android !=null){
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'tsuto',
              channel.name,
              
              // channel.description,
              icon: 'launch_background',
            ),
          ));
      }else{
        print('aaaaa');
      }
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
