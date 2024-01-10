import 'package:chat/components/user_tile.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/service/auth/auth_service.dart';
import 'package:chat/components/my_drawer.dart';
import 'package:chat/service/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // chat and auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService  = AuthService(); 

  void logout(){
    //get suth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("H O M E"),
      ),
       drawer:  const MyDrawer(),
       body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context,snapshot){
        //error
        if(snapshot.hasError){
          return const Text("erro");
        }

        //loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading...');
        }

        //return ListView
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData,context)).toList(),
        );

      }
      );
  }

  //build indivisual list tile for user
  Widget _buildUserListItem(Map<String,dynamic> userData,BuildContext context){
    //display all user except current user
   if(userData['email'] != _authService.getCurrentUser()!.email ){
     return UserTile(
      text: userData['email'],
      ontap: (){
        //tap on user to go to the chat page
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(receiverEmail: userData['email'], receiverID: userData["uid"],)));
      },
      );
   }else{
    return Container();
   }

  }
}