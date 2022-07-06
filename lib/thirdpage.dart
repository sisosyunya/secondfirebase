import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

// /画像選択パッケージ
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';
// import 'package:second_firebase/main.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';


class ThirdPage extends StatefulWidget {
  @override
  _ThirdPage createState() => _ThirdPage();
}
// staticは値が変わることなく使える

class _ThirdPage extends State<ThirdPage> {
  Image? _img;
  Text? _text;

// Future型は非同期処理を定義するときにマスト
  Future<void> _download() async {
     await FirebaseAuth.instance.signInWithEmailAndPassword(email: 
    "tesutodesuyo@gmail.com", password: 'tesutodesuyorosiku');
    // ファイルのダウンロード(テキストファイルを置いとくこともできる)
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference textRef = storage.ref().child("Dounload");
    //Reference ref = storage.ref("DL/hello.txt"); // refで一度に書いてもOK
    var data = await textRef.getData(); 

    // 画像のダウンロード
    Reference imageRef = storage.ref().child("Dounload");
    // Reference imageRef = storage.ref().child("Dounload");
    String imageUrl = await imageRef.getDownloadURL();

    // 画面に反映
    setState((){
      _img = Image.network(imageUrl);
      _text = Text(ascii.decode(data!));
    });

    // ディレクトリで端末のファイルを取得
    Directory appDocDir = await getApplicationDocumentsDirectory();
    // アップロードするファイル名を指定 
    File downloadToFile = File("${appDocDir.path}/download-logo.png");
    try{
      await imageRef.writeToFile(downloadToFile);
    }catch(e){
      print(e);
    }
    }

    void _upload() async {
      final ImagePicker _picker = ImagePicker();
      // imagePickerで画像を選択
      final pickerFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      // PickedFile pickerFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      File file = File(pickerFile!.path);

      FirebaseStorage storage = FirebaseStorage.instance;
      try{
        await storage.ref("Upload/upload-pic.png").putFile(file);
      }catch(e){
        print(e);
      }
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar:AppBar(
          title:Text('Firestorageからダウンロード・アップロード'),
        ),
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(_text != null) _text!,
              if(_img != null) _img!,
            ],
          ),
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        FloatingActionButton(
          onPressed: _download,
          child: Icon(Icons.download_outlined),
        ),
        FloatingActionButton(
          onPressed: _upload,
          child: Icon(Icons.file_upload_outlined),
          ),
            ]
            )
            );
    }
  }
