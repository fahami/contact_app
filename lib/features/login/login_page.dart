import 'package:contact_app/features/home/home_page.dart';
import 'package:contact_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi There!', style: Get.textTheme.titleMedium),
            const Text('Please login to see your contact list'),
            const SizedBox(height: 40),
            RichText(
              text: const TextSpan(
                text: 'User ID',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: '*',
                    style: TextStyle(color: red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: '019237sxfsdsasd',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 45),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: () => Get.off(HomePage.new),
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
