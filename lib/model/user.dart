import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  String id;
  String profilePicture;
  String firstName;
  String lastName;
  String email;
  int age;
  String gender;
  String about;
  String bio;

  UserModel({
    required this.id,
    required this.profilePicture,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    required this.gender,
    required this.about,
    required this.bio
});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      profilePicture: doc.data().toString().contains('profilePicture')
          ? doc['profilePicture'] as String
          : 'profilePicture key does no exist inside firebase document',
      firstName: doc.data().toString().contains('first name')
          ? doc['first name'] as String
          : 'first name key does no exist inside firebase document',
      lastName: doc.data().toString().contains('last name')
          ? doc['last name'] as String
          : 'last name key does no exist inside firebase document',
      email: doc.data().toString().contains('email')
          ? doc['email'] as String
          : 'email key does no exist inside firebase document',
      age: doc.data().toString().contains('age')
          ? doc['age']
          : 'age key does no exist inside firebase document',
      gender: doc.data().toString().contains('gender')
          ? doc['gender'] as String
          : 'gender key does no exist inside firebase document',
      about: doc.data().toString().contains('about')
          ? doc['about'] as String
          : 'about key does no exist inside firebase document',
      bio: doc.data().toString().contains('bio')
          ? doc['bio'] as String
          : 'bio key does no exist inside firebase document',
    );
  }
}