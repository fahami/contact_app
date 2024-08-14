import 'package:contact_app/services/auth_service.dart';
import 'package:contact_app/services/contacts_service.dart';
import 'package:contact_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

class ContactListView extends GetView<ContactsService> {
  const ContactListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts'),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              onChanged: controller.search,
              decoration: InputDecoration(
                hintText: 'Search your contact list...',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.loadContacts,
                  child: GroupedListView(
                    elements: controller.searchResults.isNotEmpty ? controller.searchResults.value : controller.contacts.value,
                    groupBy: (element) => element.firstName[0],
                    groupSeparatorBuilder: (groupValue) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(groupValue, style: Get.textTheme.titleMedium?.copyWith(color: blue, fontWeight: FontWeight.bold)),
                          const Divider(),
                        ],
                      ),
                    ),
                    itemBuilder: (context, contact) => ListTile(
                      minVerticalPadding: 20,
                      leading: CircleAvatar(
                        child: Text(contact.initialName.toUpperCase()),
                      ),
                      title: RichText(
                        text: TextSpan(
                          text: contact.fullName,
                          style: Get.textTheme.titleMedium,
                          children: [
                            if (contact.id == AuthService.to.currentUser.value.id)
                              TextSpan(
                                text: ' (you)',
                                style: Get.textTheme.titleMedium?.copyWith(color: grey, fontStyle: FontStyle.italic),
                              ),
                          ],
                        ),
                      ),
                      onTap: () => controller.editContact(contact),
                    ),
                  ),
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: controller.addContact,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
