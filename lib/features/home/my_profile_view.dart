import 'package:contact_app/services/auth_service.dart';
import 'package:contact_app/services/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileView extends GetView<AuthService> {
  MyProfileView({super.key});

  final contactController = Get.find<ContactsService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: controller.logout,
            child: Text(
              'Logout',
              style: TextStyle(color: Get.theme.primaryColor),
            ),
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 34),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                child: Text(controller.currentUser.value.initialName, style: Get.textTheme.displaySmall?.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              Text(controller.currentUser.value.fullName, style: Get.textTheme.titleMedium),
              const SizedBox(height: 10),
              if (controller.currentUser.value.email != null) Text(controller.currentUser.value.email!, style: Get.textTheme.titleMedium),
              const SizedBox(height: 10),
              if (controller.currentUser.value.dateOfBirth != null) Text(controller.currentUser.value.dateOfBirth!, style: Get.textTheme.titleMedium),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: () => contactController.editContact(controller.currentUser.value),
                  child: const Text('Update my detail'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
