class ContactModel {
  ContactModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.email,
  });

  factory ContactModel.initial() {
    return ContactModel(
      id: '',
      firstName: '',
      lastName: '',
    );
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      dateOfBirth: json['dob'] as String?,
      email: json['email'] as String?,
    );
  }

  String id;
  String firstName;
  String lastName;
  String? dateOfBirth;
  String? email;

  String get fullName => '$firstName $lastName';

  String get initialName => firstName.isEmpty || lastName.isEmpty ? '' : firstName[0] + lastName[0];
}
