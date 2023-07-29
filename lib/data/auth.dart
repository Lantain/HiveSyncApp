import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final String? token;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    final googleAuth = await googleSignInAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
