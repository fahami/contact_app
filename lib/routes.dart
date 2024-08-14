import 'package:contact_app/auth_middleware.dart';
import 'package:contact_app/features/contact/contact_detail_page.dart';
import 'package:contact_app/features/home/home_page.dart';
import 'package:contact_app/features/login/login_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  // Route names
  static const home = '/';
  static const details = '/details';
  static const login = '/login';

  // Route definitions
  static final routes = [
    GetPage(
      name: home,
      page: HomePage.new,
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: details,
      page: ContactDetailPage.new,
    ),
    GetPage(
      name: login,
      page: LoginPage.new,
    ),
  ];
}
