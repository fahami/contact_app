import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/services/auth_service.dart';
import 'package:contact_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ContactDetailController extends GetxController {
  @override
  void onInit() {
    if (Get.arguments != null) {
      contact(Get.arguments as ContactModel?);
      dob.text = contact.value.dateOfBirth ?? '';
    }
    if (Get.parameters['mode'] == 'add') {
      isNew(true);
    }
    super.onInit();
  }

  final contact = ContactModel.initial().obs;
  final dob = TextEditingController();
  final isNew = false.obs;
  final formKey = GlobalKey<FormState>();

  void save() {
    if (!formKey.currentState!.validate()) return;

    final validUser = validateContact(contact.value);
    if (!validUser) return;

    // Save contact
    Get.back(
      result: {
        'contact': contact.value,
        'action': 'save',
      },
    );
  }

  void delete() {
    if (contact.value.id == AuthService.to.currentUser.value.id) {
      EasyLoading.showError('You cannot delete your own contact');
      return;
    }
    
    // Delete contact
    Get.back(
      result: {
        'contact': contact.value,
        'action': 'delete',
      },
    );
  }

  bool validateContact(ContactModel value) {
    if (value.fullName.isEmpty) return false;

    if (value.lastName.isEmpty) return false;

    return true;
  }

  Future<void> pickDate(BuildContext context) async {
    final initialDate = contact.value.dateOfBirth ?? dateFormat.format(DateTime.now());
    final result = await showDatePicker(
      context: context,
      initialDate: dateFormat.parse(initialDate),
      firstDate: DateTime(1970),
      lastDate: DateTime(2200),
    );

    if (result != null) {
      dob.text = dateFormat.format(result);
      contact.update((val) => val?.dateOfBirth = dateFormat.format(result));
    }
  }
}
