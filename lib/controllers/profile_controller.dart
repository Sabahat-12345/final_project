import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isEditing = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  Future<void> loadProfile() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      nameController.text = data['name'] ?? '';
      emailController.text = data['email'] ?? '';
      phoneController.text = data['phone'] ?? '';
    }
  }

  Future<void> saveProfile() async {
    final uid = _auth.currentUser?.uid;
    final user = _auth.currentUser;
    if (uid == null || user == null) return;

    // Update Firestore data
    await _firestore.collection('users').doc(uid).update({
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
    });

    // Handle password change if new password is entered
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();

    if (oldPass.isNotEmpty && newPass.isNotEmpty) {
      try {
        // Re-authenticate the user
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPass,
        );
        await user.reauthenticateWithCredential(credential);

        // Update password
        await user.updatePassword(newPass);

        Get.snackbar("Success", "Password updated successfully");
      } catch (e) {
        Get.snackbar("Error", "Password update failed: ${e.toString()}");
      }
    }

    isEditing.value = false;
    Get.snackbar('Success', 'Profile updated');
  }

  void logout() async {
    await _auth.signOut();
    Get.offAll(() => LoginScreen()); // Or your login route
  }
}
