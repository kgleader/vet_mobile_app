import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
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
    // Бул функция азырынча өчүрүлгөн, null кайтарат.
    return null; 

    /* 
    try {
      String fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.${imageFile.path.split('.').last}';
      Reference storageRef = _storage.ref().child('profile_images/$userId/$fileName');
      
      UploadTask uploadTask = storageRef.putFile(imageFile);
      
      TaskSnapshot snapshot = await uploadTask;
      
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw Exception('Сүрөттү Firebase Storage\'га жүктөөдө ката: ${e.message}');
    } catch (e) {
      throw Exception('Сүрөт жүктөөдө күтүлбөгөн ката.');
    }
    */
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
      await _googleSignIn.signOut(); // Google менен кирген болсо, аны да чыгаруу
      await _auth.signOut();
    } catch (e) {
      // Ката кетсе, аны кайра ыргытуу же иштетүү
      // Мисалы: print("Чыгууда ката: $e");
      rethrow;
    }
  }
}