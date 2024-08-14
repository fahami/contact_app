import 'package:contact_app/features/contact/contact_detail_controller.dart';
import 'package:contact_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetailPage extends GetView<ContactDetailController> {
  const ContactDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        centerTitle: false,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: AutofillGroup(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      child: controller.contact.value.initialName.isNotEmpty
                          ? Text(controller.contact.value.initialName.toUpperCase(), style: Get.textTheme.displaySmall?.copyWith(color: Colors.white))
                          : const Icon(Icons.person_outline, size: 50),
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
                    initialValue: controller.contact.value.firstName,
                    autofillHints: const [AutofillHints.givenName],
                    onChanged: (value) {
                      controller.contact.update((val) => val?.firstName = value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First name is required';
                      }
                      return null;
                    },
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
                    initialValue: controller.contact.value.lastName,
                    autofillHints: const [AutofillHints.familyName],
                    onChanged: (value) {
                      controller.contact.update((val) => val?.lastName = value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Last name is required';
                      }
                      return null;
                    },
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
                    initialValue: controller.contact.value.email,
                    autofillHints: const [AutofillHints.email],
                    onChanged: (value) {
                      if (GetUtils.isEmail(value)) {
                        controller.contact.update((val) => val?.email = value);
                      }
                    },
                    validator: (value) {
                      if (value != null && value.isNotEmpty && !GetUtils.isEmail(value)) {
                        return 'Invalid email';
                      }

                      return null;
                    },
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
                    readOnly: true,
                    controller: controller.dob,
                    onTap: () => controller.pickDate(context),
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
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomAppBar(
            padding: const EdgeInsets.all(16),
            elevation: 0,
            child: controller.isNew.value
                ? SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonal(
                      onPressed: controller.save,
                      child: const Text('Save'),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.tonal(
                          onPressed: controller.save,
                          child: const Text('Update'),
                        ),
                      ),
                      const SizedBox(height: 27),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: controller.delete,
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
          )),
    );
  }
}
