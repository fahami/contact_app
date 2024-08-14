import 'package:contact_app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final user = TextEditingController();
  static final box = GetStorage();

  static bool get isLoggedIn => box.hasData('user');

  Future<void> login(String userId) async {
    if (userId.isEmpty) {
      await EasyLoading.showError('Please enter a valid user id');
      return;
    }

    await EasyLoading.show(status: 'Logging in...');
    await box.write('user', userId);
    await EasyLoading.dismiss();

    user.text = '';
    
    // Redirect to home page
    await Get.offAllNamed(AppRoutes.home);

  }

  Future<void> logout() async {
    await EasyLoading.show(status: 'Logging out...');
    await box.remove('user');
    await EasyLoading.dismiss();

    // Redirect to login page
    await Get.offAllNamed(AppRoutes.login);
  }
}
