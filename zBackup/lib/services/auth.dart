import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final googleSignin = GoogleSignIn();
  Future signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signEmailPassword(String email, password) async {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future createEmailPassword() async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: 'Deepjyoti120281@gmail.com',
      password: 'Deep123456',
    );
  }

  Future<void> anonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future signOut() async {
    final googleSignin = GoogleSignIn();
    final firebaseAuth = FirebaseAuth.instance;
    await googleSignin.signOut();
    await firebaseAuth.signOut();
  }
}
