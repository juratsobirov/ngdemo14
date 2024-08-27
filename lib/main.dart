import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo14_again/pages/signin_page.dart';
import 'package:ngdemo14_again/pages/signup_page.dart';
import 'package:ngdemo14_again/pages/splash_page.dart';

import 'pages/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBwa07TrnaKG5qJ1kVTeWa7OABuOT-lXZI',
      appId: '1:696416674181:android:cae3f430cfa44b94d9a4ec',
      messagingSenderId: '696416674181',
      projectId: 'ngdemo14again',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _startPage(){
  return StreamBuilder<User?>(
    stream:FirebaseAuth.instance.authStateChanges(),
    builder:(BuildContext context, snapshot){
     if(snapshot.hasData){
       return HomePage();
     }else{
       return SignInPage();
     }
    }
  );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashPage(),

      routes: {
        HomePage.id: (context) => HomePage(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
      },
    );
  }
}