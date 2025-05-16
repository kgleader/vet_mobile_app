import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // For signing in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      debugPrint("AuthService: Starting Google Sign In process");
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        debugPrint("AuthService: Google Sign in was cancelled by user");
        return null; // Колдонуучу баш тартса, null кайтарат
      }
      debugPrint("AuthService: Google User obtained: ${googleUser.displayName}");
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      debugPrint("AuthService: Obtained Google auth tokens. AccessToken: ${googleAuth.accessToken != null}, IDToken: ${googleAuth.idToken != null}");
      
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      debugPrint("AuthService: Firebase credential created");
      
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      debugPrint("AuthService: Signed in with Firebase. User: ${userCredential.user?.uid}");
      return userCredential;
    } catch (e, stackTrace) { // Ката менен кошо stack trace'ти да кармайлы
      debugPrint("AuthService: Error during Google sign in: $e");
      debugPrint("AuthService: StackTrace: $stackTrace"); // Stack trace'ти чыгарабыз
      // Бул жерде катаны колдонуучуга көрсөтүү үчүн атайын логика кошсоңуз болот,
      // мисалы, SnackBar аркылуу.
      // Эгер катаны кайра ыргытсаңыз (rethrow), ал login_screen'деги catch'ке жетет.
      rethrow; 
    }
  }
}