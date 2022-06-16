import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Secondpage.dart';
void main() async {
  // firebaseのインスタンス化（初期化）
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
    // await FirebaseAuth.instance.signInAnonymously();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({Key? key, required this.title}) : super(key: key);
  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String newEmail = "";
  String newPassword = "";
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('テストです'),
      ),
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // テキスト入力ラベル
                TextFormField(
                decoration:InputDecoration(labelText:"メールアドレス"),
                onChanged:(String value){
                  setState(() {
                    newEmail = value;
                  });
                }
                ),
                const SizedBox(height:8),
                TextFormField(
                  decoration: InputDecoration(labelText:"パスワード"),
                  // パスワードガ見えないようにする
                  obscureText:true,
                  onChanged: (String value){
                    setState((){
                      newPassword = value;
                    });
                  },
                ),
                const SizedBox(height:8),
                ElevatedButton(
                  onPressed: () async {
                    try{
                      // メールとパスワードでユーザー検索
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final UserCredential result = 
                      await auth.createUserWithEmailAndPassword(
                        email: newEmail,
                        password: newPassword,
                      );
                      final User user = result.user!;
                      setState(() {
                        infoText = "登録完了しました${user.email}";
                      });
                    }catch(e){
                      setState(() {
                        infoText = "登録できませんでした${e.toString()}";
                      });
                    }
                  },
                  child:Text("ユーザー登録"),
                ),
                const SizedBox(height:8),
                Text(infoText),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondPage()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
