import 'package:contact_app/routes.dart';
import 'package:contact_app/services/auth_service.dart';
import 'package:contact_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: blue).copyWith(secondary: blue),
      ),
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
      builder: EasyLoading.init(),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService(), permanent: true);
      }),
    );
  }
}
