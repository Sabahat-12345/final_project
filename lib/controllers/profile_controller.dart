import 'package:final_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController(text: "John Doe");
  final emailController = TextEditingController(text: "john.doe@example.com");
  final phoneController = TextEditingController(text: "1234567890");

  final isEditing = false.obs;

  void toggleEditing() => isEditing.value = !isEditing.value;

  void saveProfile() {
    toggleEditing();
    Get.snackbar("Success", "Profile updated successfully!",
        snackPosition: SnackPosition.BOTTOM);
  }

  void logout() {
    // Optionally clear user data
    nameController.clear();
    emailController.clear();
    phoneController.clear();

    // Navigate to Login screen
   Get.offAll(() => LoginScreen()); // Make sure '/login' route exists
  }
}
