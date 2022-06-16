
import 'package:flutter/material.dart';
import 'package:second_firebase/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:second_firebase/thirdpage.dart';


// これでstateを扱うことができる
class SecondPage extends StatefulWidget {
  @override
  _SecondPage createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  List<DocumentSnapshot> documentList = [];

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
                // setでドキュメント作成
                await FirebaseFirestore.instance.collection('users').doc('id_abc').set({'name':'鈴木','age':40});
              },
              ),
            ElevatedButton(
              child:Text('ドキュメント一覧取得'),
              onPressed: () async {
                // コレクション内のドキュメント一覧を取得
                final snapshot = await FirebaseFirestore.instance.collection('users').get();
                // 取得したドキュメント一覧を反映 
                setState((){
                  documentList = snapshot.docs;
                });
              },
              ),
            // コレクション内のドキュメント一覧を表示
            Column(
              children: documentList.map((document){
                return ListTile(
                  title:Text('${document['name']}さん'),
                  subtitle:Text('${document['age']}歳'),
                );
              }).toList(), 
            ),
            ElevatedButton(
              child:Text('ドキュメント更新'),
              onPressed: ()async{
                // ドキュメント更新
                await FirebaseFirestore.instance.collection('users').doc('id_abc').update({'name':'鈴木','age':50});
              },
              ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
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