// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:stride/utils/formatters/formatter.dart';

// class UserModel {
//   final String id;
//   String firstName;
//   String lastName;
//   final String username;
//   final String email;
//   String phoneNumber;
//   String profilePicture;
  

//   UserModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.username,
//     required this.email,
//     required this.phoneNumber,
//     required this.profilePicture,
   
//   });

  

//   String get fullName => "$firstName $lastName";

//   String get formattedPhoneNo => BFormatter.formatPhoneNumber(phoneNumber);

//   static List<String> nameParts(fullName) => fullName.split(" ");

//   static String generatedUsername(fullName) {
//     List<String> nameParts = fullName.split(" ");
//     String firstName = nameParts[0].toLowerCase();
//     String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
//     return "cwt_$firstName$lastName";
//   }

//   static UserModel empty() => UserModel(
//         id: '',
//         firstName: '',
//         lastName: '',
//         username: '',
//         email: '',
//         phoneNumber: '',
//         profilePicture: '',
        
//       );

//   Map<String, dynamic> toJson() {
//     return {
//       'FirstName': firstName,
//       'LastName': lastName,
//       'Username': username,
//       'Email': email,
//       'PhoneNumber': phoneNumber,
//       'ProfilePicture': profilePicture,
//      // 'Cart': cartItemsToJson(),  // Include cart serialization.
//     };
//   }

//   factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     if (document.data() != null) {
//       final data = document.data()!;
//       return UserModel(
//         id: document.id,
//         firstName: data['FirstName'] ?? '',
//         lastName: data['LastName'] ?? '',
//         username: data['Username'] ?? '',
//         email: data['Email'] ?? '',
//         phoneNumber: data['PhoneNumber'] ?? '',
//         profilePicture: data['ProfilePicture'] ?? '',
       
//       );
//     } else {
//       return UserModel.empty();
//     }
//   }

 
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stride/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  String get fullName => "$firstName $lastName";

  String get formattedPhoneNo => BFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generatedUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    return "cwt_$firstName$lastName";
  }

  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
      );

  // The toJson method for serializing the object to Firestore
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  // Factory method for creating a UserModel from Firestore DocumentSnapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

  // Add the copyWith method to make it easy to update specific fields
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
