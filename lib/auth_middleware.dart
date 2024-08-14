import 'package:contact_app/routes.dart';
import 'package:contact_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final isLoggedIn = AuthService.isLoggedIn;

    if (!isLoggedIn && route != AppRoutes.login) {
      return const RouteSettings(name: AppRoutes.login);
    }
    
    return null;
  }
}
