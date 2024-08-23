import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login function
  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User successfully logged in
      User? user = userCredential.user;
      if (user != null) {
        // Optionally handle post-login logic here
        print('User logged in: ${user.email}');
      }
    } on FirebaseAuthException catch (e) {
      // Handle error (e.g., wrong password, user not found)
      print('Error during login: ${e.message}');
    }
  }

  // Logout function
  Future<void> logout() async {
    await _auth.signOut();
    print('User logged out');
  }
}
