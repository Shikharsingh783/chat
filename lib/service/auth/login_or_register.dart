import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegsiterState();
}

class _LoginOrRegsiterState extends State<LoginOrRegister> {
  //intially show login page
  bool showLoginPage = true;

  //toggle between l;ogina and register page
  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
 
  @override
  Widget build(BuildContext context) {
   if (showLoginPage) {
    return LoginPage(onTap: togglePage,);
   }else{
    return RegisterPage(onTap: togglePage,);
   }
  }
}