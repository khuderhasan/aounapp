class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String accountType;

  UserModel({
    required this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.accountType,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      firstName: json['firstName'],
      email: json['email'],
      lastName: json['lastName'],
      accountType: json['accountType']);
  Map<String, dynamic> toMap() => {
        "id": id,
        "firsName": firstName,
        "email": email,
        "lastName": lastName,
        "accountType": accountType,
      };
}
