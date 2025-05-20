import 'package:final_project/screens/forget_password_screen.dart';
import 'package:final_project/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../widgets/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Icon(Icons.lock_open,
                          size: 70, color: Colors.green),
                      const SizedBox(height: 20),
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomInputField(
                        hintText: "Email",
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomInputField(
                                hintText: "Password",
                                controller: controller.passwordController,
                                obscureText: controller.isPasswordHidden.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordHidden.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.offAll(() => ForgetPasswordScreen());
                                },
                                child: const Text("Forgot Password?"),
                              ),
                            ],
                          )),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: controller.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Get.offAll(() => SignUpScreen());
                            },
                            child: const Text("Sign Up"),
                          )
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              )),
      ),
    );
  }
}
