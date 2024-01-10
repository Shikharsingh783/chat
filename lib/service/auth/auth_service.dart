import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  //instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get currrent usre
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithWEmailPassword(String email,password)async{
    //sign user in
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    
    //save user info if it does'nt alreday exist
    _firestore.collection('Users').doc(userCredential.user!.uid).set(
      {
        'uid': userCredential.user!.uid,
        'email': email
      }
    );
    
    return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }

  }

  //sign up
  Future<UserCredential> signUpWithEmailPassword(String email,String password)async{
    //create user
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    
    // save user info in seperate document
    _firestore.collection('Users').doc(userCredential.user!.uid).set(
      {
        'uid': userCredential.user!.uid,
        'email': email
      }
    );

    return userCredential;
    } on FirebaseException catch(e){
      throw Exception(e.code);
  }
  }

  //sign out
  Future <void> signOut()async{
    return await _auth.signOut();
  }

  //error

}