import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo14_again/pages/home_page.dart';
import 'package:ngdemo14_again/pages/signup_page.dart';

import '../services/auth_service.dart';
import '../services/prefs_service.dart';
import '../services/utils_service.dart';

class SignInPage extends StatefulWidget {
  static const String id = "signin_page";

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  var isLoading = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignIn(){
  String email = emailController.text.toString().trim();
  String password = passwordController.text.toString().trim();
if(email.isEmpty || password.isEmpty) return;

setState((){
  isLoading = true;
});

  AuthService.signInUser(context, email, password).then((fireBaseUser) => {
    _getFirebaseUser(fireBaseUser),
  });
  }

  _getFirebaseUser(User? firebaseUser)async{
    setState((){
      isLoading = false;
    });
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      _callHomePage();
    }else{
    Utils.fireToast("Check your email or password");
    }
  }

  _callHomePage(){
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: MaterialButton(
                      onPressed: _doSignIn,
                      color: Colors.blue,
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, SignUpPage.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Don`t have an account?",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

}
