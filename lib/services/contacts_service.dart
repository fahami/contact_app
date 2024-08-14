import 'dart:convert';

import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/routes.dart';
import 'package:contact_app/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ContactsService extends GetxController {
  @override
  void onInit() {
    loadContacts();
    super.onInit();
  }

  final contacts = <ContactModel>[].obs;
  final searchResults = <ContactModel>[].obs;

  static Future<ContactModel?> findUser(String userId) async {
    // Load data.json from assets
    final jsonData = await rootBundle.loadString('assets/data.json');
    final users = jsonDecode(jsonData) as List;

    // Find user with matching id
    for (final user in users) {
      if (user['id'] == userId) {
        return ContactModel.fromJson(user as Map<String, dynamic>);
      }
    }

    return null;
  }

  Future<void> loadContacts() async {
    try {
      // Load data.json from assets
      final jsonData = await rootBundle.loadString('assets/data.json');
      final users = jsonDecode(jsonData) as List;

      // Convert json data to ContactModel
      contacts.value = users.map((user) => ContactModel.fromJson(user as Map<String, dynamic>)).toList();

      // Reset current user at AuthService based on user id
      resetUserOnAuthService();
    } catch (e) {
      await EasyLoading.showError('Error: $e');
    }
  }

  void resetUserOnAuthService() {
    // Reset current user at AuthService based on user id
    final currentUser = AuthService.to.currentUser.value;

    final user = contacts.firstWhere((c) => c.id == currentUser.id, orElse: () => currentUser);
    AuthService.to.currentUser.value = user;
    AuthService.to.currentUser.refresh();
  }

  void search(String query) {
    if (query.isEmpty) {
      searchResults.value = contacts;
      return;
    }

    searchResults.value = contacts.where((contact) {
      return contact.fullName.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<void> editContact(ContactModel contact) async {
    final result = await Get.toNamed(AppRoutes.details, arguments: contact);
    if (result == null) return;

    // Save contact
    if (result['action'] == 'save') {
      final updatedContact = result['contact'] as ContactModel;
      final index = contacts.indexWhere((c) => c.id == updatedContact.id);
      contacts[index] = updatedContact;

      // Replace contact in auth service if it matches
      if (AuthService.to.currentUser.value.id == updatedContact.id) {
        AuthService.to.currentUser.value = updatedContact;
        AuthService.to.currentUser.refresh();
      }

      return;
    }

    // Delete contact
    if (result['action'] == 'delete') {
      final deletedContact = result['contact'] as ContactModel;
      contacts.removeWhere((c) => c.id == deletedContact.id);

      return;
    }
  }

  Future<void> addContact() async {
    final result = await Get.toNamed(AppRoutes.details, parameters: {'mode': 'add'});
    if (result == null) return;

    // Save contact
    if (result['action'] == 'save') {
      final newContact = result['contact'] as ContactModel;
      contacts.add(newContact);

      return;
    }
  }
}
