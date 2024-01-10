import 'package:chat/service/auth/auth_service.dart';
import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_textfeild.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.onTap});

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();

  final void Function()? onTap;

  void login(BuildContext context)async{
    //auth service
    final authService =  AuthService();

    //try login
    try{
      await authService.signInWithWEmailPassword(_emailcontroller.text, _pwcontroller.text);
    }

    //catch erroe
    catch(e){
      showDialog(context: context, builder: (context)=> AlertDialog(title: Text(e.toString()),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            //logo
            Icon(Icons.message,size: 60,color: Theme.of(context).colorScheme.primary,),

            const SizedBox(height: 50,),
            //welcome back mssg
            Text("Welcome back, you've been missed!",style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.primary),),

           const SizedBox(height: 50,),
        
            //email text
            MyTextfeild(hintText: 'Email',obsecureText:false, controller: _emailcontroller,),

            const SizedBox(height: 10,),

            //password
            MyTextfeild(hintText: 'Password',obsecureText:true, controller: _pwcontroller,),

            const SizedBox(height: 25,),

            //login button
            MyButton(text: 'Login', ontap:() => login(context),),

            const SizedBox(height: 25,),
        
            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a memeber? ",style:TextStyle(color: Theme.of(context).colorScheme.primary)),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register now",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}