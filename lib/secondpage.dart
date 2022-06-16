
import 'package:flutter/material.dart';
import 'package:second_firebase/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Firestoreにデータ保存'),
      ),
      body:Center(
        child:Column(
          children:<Widget> [
            ElevatedButton(
              child: Text('コレクション＋ドキュメント作成'),
              onPressed: ()async{
                await FirebaseFirestore.instance.collection('users').doc('id_abc').set({'name':'鈴木','age':40});
              },
              ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child:const Text('次の画面へ'),
            ),
          ],
        ),
      ),
    );
  }
}