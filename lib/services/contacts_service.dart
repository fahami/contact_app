import 'dart:convert';

import 'package:contact_app/models/contact_model.dart';
import 'package:flutter/services.dart';

class ContactsService {
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
}
