import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ngdemo14_again/pages/signin_page.dart';

import '../services/auth_service.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  _callNextPage(){
    if(AuthService.isLoggedIn()){
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Navigator.pushReplacementNamed(context, SignInPage.id);
    }
  }

  _initTimer(){
    Timer(const Duration(seconds: 4), (){
      _callNextPage();
    });
  }

@override
  void initState() {
   super.initState();
_initTimer();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child:Text("Welcome!!!", style:TextStyle(fontSize:30)),
        ),
        Text("...this Splash page", style:TextStyle(fontSize:10),),
      ],
    ),
    );
  }
}