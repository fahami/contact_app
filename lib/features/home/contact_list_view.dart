import 'package:contact_app/features/contact/contact_detail_page.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/utils/app_colors.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

class ContactListView extends StatelessWidget {
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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your contact list...',
                suffixIcon: const Icon(Icons.search),
                // suffixIconColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.focused) ? blue : grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GroupedListView(
              elements: List.generate(
                100,
                (index) => ContactModel(
                  name: faker.person.name(),
                  email: faker.internet.email(),
                  phoneNumber: faker.phoneNumber.us(),
                ),
              ),
              groupBy: (element) => element.name[0],
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
              itemBuilder: (context, element) => ListTile(
                minVerticalPadding: 20,
                leading: CircleAvatar(
                  child: Text(element.name.split(' ').sublist(0, 2).map((c) => c[0]).join().toUpperCase()),
                ),
                title: Text(element.name),
                onTap: () => Get.to(ContactDetailPage.new),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () => Get.to(ContactDetailPage.new),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
