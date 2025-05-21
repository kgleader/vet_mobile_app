import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart'; // Кошулду
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Firebase Storage үчүн

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Кошулду
  final FirebaseStorage _storage = FirebaseStorage.instance; // Firebase Storage үчүн

  // Google менен кирүү үчүн
  Future<UserCredential?> signInWithGoogle() async {
    try {
      debugPrint("AuthService: Google менен кирүү процесси башталууда");
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        debugPrint("AuthService: Google менен кирүү колдонуучу тарабынан жокко чыгарылды");
        return null; // Колдонуучу баш тартса, null кайтарат
      }
      debugPrint("AuthService: Google колдонуучусу алынды: ${googleUser.displayName}");
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      debugPrint("AuthService: Google аутентификация токендери алынды. AccessToken: ${googleAuth.accessToken != null}, IDToken: ${googleAuth.idToken != null}");
      
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      debugPrint("AuthService: Firebase credential түзүлдү");
      
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      debugPrint("AuthService: Firebase менен кирүү аяктады. Колдонуучу: ${userCredential.user?.uid}");
      return userCredential;
    } catch (e, stackTrace) { // Ката менен кошо stack trace'ти да кармайлы
      debugPrint("AuthService: Google менен кирүүдө ката: $e");
      debugPrint("AuthService: StackTrace: $stackTrace"); // Stack trace'ти чыгарабыз
      // Бул жерде катаны колдонуучуга көрсөтүү үчүн атайын логика кошсоңуз болот,
      // мисалы, SnackBar аркылуу.
      // Эгер катаны кайра ыргытсаңыз (rethrow), ал login_screen'деги catch'ке жетет.
      rethrow; 
    }
  }

  // Электрондук почта жана сыр сөз менен катталып, маалыматтарды Firestore'го сактоо үчүн
  Future<UserCredential?> signUpWithEmailPasswordAndSaveData({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      debugPrint("AuthService: $email үчүн Электрондук почта/Сыр сөз менен катталуу процесси башталууда");
      // Электрондук почта жана сыр сөз менен колдонуучуну түзүү
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("AuthService: Колдонуучу UID менен түзүлдү: ${userCredential.user?.uid}");

      // Кошумча колдонуучу маалыматтарын Firestore'го сактоо
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'createdAt': Timestamp.now(), // Кошумча: колдонуучу качан түзүлгөнүн билүү үчүн
        });
        debugPrint("AuthService: Колдонуучунун маалыматтары Firestore'го UID үчүн сакталды: ${userCredential.user!.uid}");
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint("AuthService: Электрондук почта/Сыр сөз менен катталуу учурунда FirebaseAuthException: ${e.message} (код: ${e.code})");
      // Белгилүү Firebase Auth каталарын иштетүү (мис., email-already-in-use)
      // Сиз атайын бир exception ыргыткыңыз же белгилүү бир ката кодун кайтаргыңыз келиши мүмкүн
      rethrow;
    } catch (e, stackTrace) {
      debugPrint("AuthService: Электрондук почта/Сыр сөз менен катталуу же Firestore'го сактоо учурунда жалпы ката: $e");
      debugPrint("AuthService: StackTrace: $stackTrace");
      rethrow;
    }
  }

  // Электрондук почта жана сыр сөз менен кирүү үчүн
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
    } on FirebaseAuthException catch (e) {
      // Сиз UI катмарында кармоо үчүн исключени кайра ыргытсаңыз болот,
      // же эгер керек болсо, бул жерде белгилүү бир каталарды иштетсеңиз болот.
      print('AuthService: FirebaseAuthException кирүү учурунда: ${e.code} - ${e.message}');
      rethrow; // Исключени кайра ыргытуу UI'га белгилүү бир ката коддорун иштетүүгө мүмкүнчүлүк берет
    } catch (e) {
      print('AuthService: Кирүү учурунда жалпы ката: $e');
      // Башка каталарды иштетүү же кайра ыргытуу
      throw Exception('Кирүү учурунда күтүлбөгөн ката болду.');
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      // UI катмарына катаны жеткирүү үчүн кайра ыргытуу
      rethrow;
    } catch (e) {
      // Башка күтүлбөгөн каталар
      throw Exception('Сыр сөздү калыбына келтирүү катын жөнөтүүдө ката кетти.');
    }
  }

  Future<String?> uploadProfileImage({required String userId, required File imageFile}) async {
    // ПРОФИЛЬ СҮРӨТҮН ЖҮКТӨӨ ФУНКЦИЯСЫ АЗЫРЫНЧА ӨЧҮРҮЛГӨН
    // Эгер бул функцияны кайра иштетүү керек болсо, төмөнкү комментарийге алынган кодду активдештириңиз.
    // жана Firebase Storage туура конфигурацияланганын текшериңиз.
    debugPrint('AuthService: uploadProfileImage чакырылды, бирок функция азырынча өчүрүлгөн. userId: $userId');
    return null; // Сүрөт жүктөлбөгөндүктөн, null кайтарабыз.

    /* // ТӨМӨНКҮ КОД УБАКТЫЛУУ ӨЧҮРҮЛДҮ (ПРОФИЛЬ СҮРӨТҮН ЖҮКТӨӨ ҮЧҮН)
    try {
      debugPrint('AuthService: Attempting to upload profile image for user $userId');
      String fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.${imageFile.path.split('.').last}';
      Reference storageRef = _storage.ref().child('profile_images/$userId/$fileName');
      
      debugPrint('AuthService: Uploading to path: ${storageRef.fullPath}');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      
      TaskSnapshot snapshot = await uploadTask;
      debugPrint('AuthService: Image uploaded successfully. Bytes transferred: ${snapshot.bytesTransferred}');
      
      String downloadUrl = await snapshot.ref.getDownloadURL();
      debugPrint('AuthService: Got download URL: $downloadUrl');
      return downloadUrl;
    } on FirebaseException catch (e, stackTrace) {
      debugPrint('AuthService: FirebaseException during image upload: ${e.code} - ${e.message}');
      debugPrint('AuthService: StackTrace: $stackTrace');
      throw Exception('Сүрөттү Firebase Storage\'га жүктөөдө ката: ${e.message}');
    } catch (e, stackTrace) {
      debugPrint('AuthService: Generic error during image upload: $e');
      debugPrint('AuthService: StackTrace: $stackTrace');
      throw Exception('Сүрөт жүктөөдө күтүлбөгөн ката.');
    }
    */
  }

  // Firestore'го жаңыртуу методунда да ушундай логдорду кошуңуз
  Future<void> updateUserProfileData(String userId, Map<String, dynamic> data) async {
    // ЭСКЕРТҮҮ: UI катмары бул метод аркылуу 'profileImageUrl' талаасын жөнөтүшү мүмкүн.
    // Бул талаа Firestore'го сакталат. Бирок, `uploadProfileImage` методу азыркы учурда өчүрүлгөн,
    // андыктан жаңы сүрөт URL'дери Firebase Storage'дан алынып, бул жерге жазылбайт.
    // UI катмары профиль сүрөтүн көрсөтүүдө 'profileImageUrl' null же эски болушу мүмкүн экенин эске алышы керек.
    try {
      debugPrint('AuthService: Updating Firestore for user $userId with data: $data');
      await _firestore.collection('users').doc(userId).update(data);
      debugPrint('AuthService: Firestore updated successfully for user $userId');
    } on FirebaseException catch (e, stackTrace) {
      debugPrint('AuthService: FirebaseException during Firestore update: ${e.code} - ${e.message}');
      debugPrint('AuthService: StackTrace: $stackTrace');
      throw Exception('Firestore\'го маалымат сактоодо ката: ${e.message}');
    } catch (e, stackTrace) {
      debugPrint('AuthService: Generic error during Firestore update: $e');
      debugPrint('AuthService: StackTrace: $stackTrace');
      throw Exception('Маалымат сактоодо күтүлбөгөн ката.');
    }
  }
}