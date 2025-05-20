import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your email",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email);

      Get.defaultDialog(
        title: "Reset Link Sent",
        middleText: "Check your email for a password reset link.",
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("OK"),
        ),
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
