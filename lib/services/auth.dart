import 'package:firebase_auth/firebase_auth.dart';
import 'package:rhee_app/model/firebaseuser.dart';
import 'package:rhee_app/model/loginuser.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  FirebaseUser? _firebaseUser(User? user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }


  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }



  Future signInEmailPassword(LoginUser login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: login.email.toString(),
          password: login.password.toString());
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    }
  }
  Future<FirebaseUser?> getCurrentUser() async {
    User? user = _auth.currentUser;
    return firebaseUser(user);
  }

  Future registerEmailPassword(LoginUser login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: login.email.toString(),
          password: login.password.toString());
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }


  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}