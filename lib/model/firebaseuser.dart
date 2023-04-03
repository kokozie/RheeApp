import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUser {
  final String? uid ;
  final String? code; //code firebaseauth excemption
  FirebaseUser({this.uid,this.code});
}
FirebaseUser? firebaseUser(User? user) {
  return user != null ? FirebaseUser(uid: user.uid) : null;
}

