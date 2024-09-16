// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uid;
  final List<String>tweets;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime createdAt;

  UserModel(
    {required this.uid, required this.tweets, required this.firstName, required this.lastName, required this.email, required this.createdAt});
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'tweets':tweets,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return UserModel(
     uid: map['uid'] ?? '',
    firstName:   map['firstName'] ?? '',
    lastName:   map['lastName'] ?? '',
    email:   map['email'] ?? '',
    createdAt:   DateTime.parse(map['createdAt']?? DateTime.now().toIso8601String()),
     tweets: List.from(map['tweets']?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
