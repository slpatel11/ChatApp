import 'package:chatapp/screen/auth_screen.dart';
import 'package:chatapp/screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
          backgroundColor: Colors.purple,
          primarySwatch: Colors.purple,
          accentColor: Colors.pink,
          accentColorBrightness: Brightness.light,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.purple,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))
          )
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx,userSnapShot){
          if(userSnapShot.hasData){
            return ChatScreen();
          }
          return  UserAuthScreen();
      },),
    );
  }
}
