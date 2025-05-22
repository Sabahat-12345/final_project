import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../widgets/custom_input_field.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        title: const Text("My Profile"),
        centerTitle: true,
        actions: [
          Obx(() => IconButton(
                icon: Icon(controller.isEditing.value ? Icons.save : Icons.edit),
                onPressed: () {
                  controller.isEditing.value
                      ? controller.saveProfile()
                      : controller.toggleEditing();
                },
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() => Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/avatar.png'), // Replace with your image path
                ),
                const SizedBox(height: 20),
                CustomInputField(
                  hintText: "Full Name",
                  controller: controller.nameController,
                  readOnly: !controller.isEditing.value,
                ),
                const SizedBox(height: 20),
                CustomInputField(
                  hintText: "Email",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: !controller.isEditing.value,
                ),
                const SizedBox(height: 20),
                CustomInputField(
                  hintText: "Phone Number",
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  readOnly: !controller.isEditing.value,
                ),
              ],
            )),
      ),
    );
  }
}
