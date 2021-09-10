// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

  late String uid;
  late String name;
  late String phoneNumber;
  late String emailId;
  late String password;
  late DateTime timestamp;

  UserModel(
      {required this.uid,
        required this.name,
        required this.phoneNumber,
        required this.emailId,
        required this.password,
        required this.timestamp});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.id,
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      emailId: doc['emailId'],
      password: doc['password'],
      timestamp: doc['timestamp'],
    );
  }
}


// class UserModel {
//   late String uid;
//   late String name;
//   late String phoneNumber;
//   late String emailId;
//   late String password;
//   late DateTime timestamp;

//   UserModel(uid,{required this.name, required this.phoneNumber, required this.emailId, required this.password, required this.timestamp});
//
//   Map toMap(UserModel user) {
//     var data = Map<String, dynamic>();
//
//     data["uid"] = user.uid;
//     data["name"] = user.name;
//     data["phoneNumber"] = user.phoneNumber;
//     data["emailId"] = user.emailId;
//     data["password"] = user.password;
//     data["timestamp"] = user.timestamp;
//
//     return data;
//   }
//
//   UserModel.fromMap(Map<String, dynamic> mapData) {
//     this.uid = mapData["uid"];
//     this.name = mapData["name"];
//     this.phoneNumber = mapData["phoneNumber"];
//     this.emailId = mapData["emailId"];
//     this.password = mapData["password"];
//   }
// }
//
