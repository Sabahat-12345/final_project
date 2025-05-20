

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  void togglePasswordVisibility() {
  isPasswordHidden.value = !isPasswordHidden.value;
}

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    Get.snackbar("Error", "All fields are required",
        snackPosition: SnackPosition.BOTTOM);
    return;
  }

  try {
    isLoading.value = true;
    UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    if (!userCred.user!.emailVerified) {
      Get.snackbar("Email Not Verified",
          "Please verify your email before logging in.",
          snackPosition: SnackPosition.BOTTOM);

      await _auth.signOut();
      return;
    }

    Get.offAllNamed('/home');
  } catch (e) {
    Get.snackbar("Login Failed", e.toString(),
        snackPosition: SnackPosition.BOTTOM);
  } finally {
    isLoading.value = false;
  }
}
}
