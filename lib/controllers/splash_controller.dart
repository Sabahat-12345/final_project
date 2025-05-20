import 'dart:async';
import 'package:final_project/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    startDelay();
  }

  void startDelay() {
    Timer(const Duration(seconds: 3), () {
      checkAuthStatus();
    });
  }

  void checkAuthStatus() {
    if (auth.currentUser != null) {
      Get.offAllNamed('/home'); // navigate to home if user is logged in
    } else {
      Get.offAll(() => LoginScreen()); // navigate to login if not
    }
  }
}
