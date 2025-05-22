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
}
