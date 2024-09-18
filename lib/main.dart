import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/firebase_options.dart';
import 'package:project/screens/chatPage.dart';
import 'package:project/screens/loginPage.dart';
import 'package:project/screens/registerPage.dart';

void main()
async{
  runApp(chat_App());
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
}

class chat_App extends StatelessWidget {

  const chat_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginPage':(context)=>Loginpage(),
        'RegisterPage':(context)=>Registerpage(),
        'chatPage':(context)=>ChatPage()
        
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',     //  home: Loginpage(),    the same idea
    );  
  }
}