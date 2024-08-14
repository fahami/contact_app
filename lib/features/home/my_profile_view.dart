import 'package:contact_app/features/contact/contact_detail_page.dart';
import 'package:contact_app/utils/constants.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Logout',
              style: TextStyle(color: Get.theme.primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 34),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Text('A', style: Get.textTheme.displayMedium?.copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            Text(faker.person.name(), style: Get.textTheme.titleMedium),
            const SizedBox(height: 10),
            Text(faker.internet.email(), style: Get.textTheme.titleMedium),
            const SizedBox(height: 10),
            Text(dateFormat.format(faker.date.dateTime(minYear: 2000, maxYear: 2030)), style: Get.textTheme.titleMedium),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: () => Get.to(ContactDetailPage.new),
                child: const Text('Update my detail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
