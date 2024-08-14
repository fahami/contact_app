import 'dart:async';

import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/routes.dart';
import 'package:contact_app/services/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  @override
  void onInit() {
    loadCurrentUser();
    super.onInit();
  }

  final currentUser = ContactModel.initial().obs;
  final user = TextEditingController();
  static final box = GetStorage();

  static bool get isLoggedIn => box.hasData('user');

  static AuthService get to => Get.find();

  Future<void> login(String userId) async {
    try {
      if (userId.isEmpty) {
        await EasyLoading.showError('Please enter a valid user id');
        return;
      }

      final userFound = await ContactsService.findUser(userId);
      if (userFound == null) {
        await EasyLoading.showError('User not found');
        return;
      }

      // Set current user
      currentUser(userFound);

      await EasyLoading.show(status: 'Logging in...');
      await box.write('user', userId);
      await EasyLoading.dismiss();

      user.text = '';

      // Redirect to home page
      await Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      await EasyLoading.showError('Error: $e');
    }
  }

  Future<void> logout() async {
    await EasyLoading.show(status: 'Logging out...');
    await box.remove('user');
    await EasyLoading.dismiss();

    // Redirect to login page
    unawaited(Get.offAllNamed(AppRoutes.login));
    currentUser(ContactModel.initial());
  }

  Future<void> loadCurrentUser() async {
    final userId = box.read<String>('user');
    if (userId != null) {
      final user = await ContactsService.findUser(userId);
      if (user != null) {
        currentUser(user);
      }
    }
  }
}
