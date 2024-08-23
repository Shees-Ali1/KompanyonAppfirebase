import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up function
  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User successfully signed up
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('userDetails').doc(user.uid).set({
          'email':email,
          'createAt': Timestamp.now(),
        });
        print('User signed up: ${user.email}');
      }
    } on FirebaseAuthException catch (e) {

      print('Error during sign up: ${e.message}');
    }
  }
}
