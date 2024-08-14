import 'package:contact_app/utils/app_colors.dart';
import 'package:contact_app/utils/constants.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetailPage extends StatelessWidget {
  const ContactDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.person_outline, size: 50),
              ),
            ),
            const SizedBox(height: 47),
            Text(
              'Main Information',
              style: Get.textTheme.titleMedium?.copyWith(color: blue, fontStyle: FontStyle.italic),
            ),
            const Divider(),
            RichText(
              text: const TextSpan(
                text: 'First Name',
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
            TextFormField(
              initialValue: faker.person.firstName(),
              decoration: InputDecoration(
                hintText: 'Enter first name',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            RichText(
              text: const TextSpan(
                text: 'Last Name',
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
            TextFormField(
              initialValue: faker.person.lastName(),
              decoration: InputDecoration(
                hintText: 'Enter last name',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 26),
            Text(
              'Sub Information',
              style: Get.textTheme.titleMedium?.copyWith(color: blue, fontStyle: FontStyle.italic),
            ),
            const Divider(),
            const Text('Email', style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: faker.internet.email(),
              decoration: InputDecoration(
                hintText: 'Enter email',
                prefixIcon: const Icon(Icons.mail_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Date of Birth', style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: dateFormat.format(faker.date.dateTime(minYear: 1970, maxYear: 2000)),
              readOnly: true,
              onTap: () async {
                final result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2000),
                );
              },
              decoration: InputDecoration(
                hintText: 'Enter birthday',
                prefixIcon: const Icon(Icons.calendar_month_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(16),
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: Get.back,
                child: const Text('Update'),
              ),
            ),
            const SizedBox(height: 27),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: Get.back,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: red, width: 2),
                  foregroundColor: red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Remove'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
