import 'package:chat/service/auth/auth_service.dart';
import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_textfeild.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();
  final TextEditingController _confirmPwcontroller = TextEditingController();
  RegisterPage({super.key, required this.onTap});

  final void Function()? onTap;

  void register(BuildContext context) async{
    //get auth service
    final _auth = AuthService();

    //password match -> create user
    if(_pwcontroller.text == _confirmPwcontroller.text){
      try{
       await _auth.signUpWithEmailPassword(_emailcontroller.text, _pwcontroller.text);
      }
      catch(e){
        showDialog(context: context, builder: (context)=> AlertDialog(title: Text(e.toString()),));
      }
    }

    //password don't match -> tell the user
    else{
      showDialog(context: context, builder: (context)=> const AlertDialog(
        title: Text("Passwords don't match!"),
      ));
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

            const SizedBox(height: 10,),

            // confirm password
            MyTextfeild(hintText: 'Confirm Password',obsecureText:true, controller: _confirmPwcontroller,),

            const SizedBox(height: 25,),

            //login button
            MyButton(text: 'Register', ontap:() => register(context),),

            const SizedBox(height: 25,),
        
            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",style:TextStyle(color: Theme.of(context).colorScheme.primary)),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}