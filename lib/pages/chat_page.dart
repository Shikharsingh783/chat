import 'package:chat/components/chat_bubble.dart';
import 'package:chat/components/my_textfeild.dart';
import 'package:chat/service/auth/auth_service.dart';
import 'package:chat/service/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});
  final String receiverEmail;
  final String receiverID;

  //text controller
  final TextEditingController _messageController = TextEditingController();
  
  //chat and auth services
  final ChatService _chatservice =  ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage()async{
    //if there is something inside the textfeild
    if(_messageController.text.isNotEmpty){
      //send the message
      await _chatservice.sendMessage(receiverID, _messageController.text);

      //clear text controiller
      _messageController.clear();
       
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(children: [

        //display all the messages
        Expanded(
          child: _buildMessageList(),
        ),

        //user input 
        _buildUserInput()
      ],),
    );
  }

  // build message list
  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatservice.getMessages(receiverID, senderID),
     builder: (context,snapshot){

      //error
      if(snapshot.hasError){
        return const Text("Error");
       }

      //loading
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading...");
      }

      //return List view
      return ListView(
        children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(), 
      );
    });
  }

  //build message item

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String ,dynamic> data =  doc.data() as Map<String,dynamic>;

    // is current user
   bool isCurrentUser =  data['senderID'] == _authService.getCurrentUser()!.uid;  

   //aligth the message to the right if sender is the current user
   var alignment = isCurrentUser? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
         ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
        ],
      ));
  }


  //// build message input
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom:50.0),
      child: Row(
        children: [
          //textfeild should the most of the space
          Expanded(child: MyTextfeild(hintText: "Type a message....", obsecureText: false, controller: _messageController)),
      
          //send button
          Container(
            decoration: BoxDecoration(
              color:Colors.green.shade400,
              shape: BoxShape.circle
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.send_rounded,color: Colors.white,)))
        ],
      ),
    );
  }
}