import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/controller/login_controller.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';
final LoginController login = Get.put(LoginController());

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypasswordController = TextEditingController();
  var isselectedsignup = "Signup".obs;

  Future<void> handleSignUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = retypasswordController.text.trim();

    if (password != confirmPassword) {
      // Handle password mismatch
      print('Passwords do not match');
      Get.snackbar('Error', "Passwords do not match",
          backgroundColor: whiteColor, colorText: Colors.black);
      return;
    }

    try {
      login.isLoading.value = true;

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('userDetails').doc(user.uid).set({
          'email': email,
          'password': password,
          'createAt': Timestamp.now(),
        });

        Get.to(NavBar());
        Get.snackbar('Success', 'Login Success',
            backgroundColor: whiteColor, colorText: Colors.black);
        print('User signed up: ${user.email}');
        emailController.clear();
        passwordController.clear();
        retypasswordController.clear();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.back();
        Get.snackbar(
            "Error", "The email address is already in use by another account.",
            backgroundColor: whiteColor, colorText: Colors.black);
      } else {
        Get.back();
        print('error auth $e');
        Get.snackbar("Error", e.code,
            backgroundColor: whiteColor, colorText: Colors.black);
      }
    } finally {
      login.isLoading.value = false;
    }
  }

}
