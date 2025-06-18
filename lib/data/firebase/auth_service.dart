import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Lazy initialize GoogleSignIn only when needed
  GoogleSignIn? _googleSignIn;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Check if running in web mode
  bool get _isWeb => kIsWeb;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Initialize GoogleSignIn with web client ID if on web platform
      _googleSignIn ??= GoogleSignIn(
        // Optional: Specify scopes if needed
        scopes: ['email', 'profile'],
      );
      
      if (_isWeb) {
        // Web-specific sign-in flow
        final GoogleSignInAccount? googleUser = await _googleSignIn?.signIn();
        
        if (googleUser == null) {
          return null;
        }
        
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential;
      } else {
        // Mobile-specific sign-in flow (unchanged)
        final GoogleSignInAccount? googleUser = await _googleSignIn?.signIn();
        
        if (googleUser == null) {
          return null; 
        }
        
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signUpWithEmailPasswordAndSaveData({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'createdAt': Timestamp.now(),
        });
      }
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException {
      rethrow; 
    } catch (e) {
      throw Exception('Кирүү учурунда күтүлбөгөн ката болду.');
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Сыр сөздү калыбына келтирүү катын жөнөтүүдө ката кетти.');
    }
  }

  Future<String?> uploadProfileImage({required String userId, required File imageFile}) async {
    
    return null; 

    
  }

  Future<void> updateUserProfileData(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);
    } on FirebaseException catch (e) {
      throw Exception('Firestore\'го маалымат сактоодо ката: ${e.message}');
    } catch (e) {
      throw Exception('Маалымат сактоодо күтүлбөгөн ката.');
    }
  }

  Future<void> signOut() async {
    try {
      // Use conditional invocation to avoid null errors
      await _googleSignIn?.signOut();
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}