import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _fireStore = FirebaseFirestore.instance;

  static Future<bool> signUp(String firstName, String lastName, int age, String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? signedInUser = authResult.user;

      if (signedInUser != null) {
        _fireStore.collection('users').doc(signedInUser.uid).set({
          'first name': firstName,
          'email': email,
          'last name': lastName,
          'age': age,
          'profilePicture': '',
          'gender': '',
          'bio': '',
          'about': ''
        });
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static void logout() {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}