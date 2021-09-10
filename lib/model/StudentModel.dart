import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel{

  late String studentId;
  late String studentName;
  late String studentDOB;
  late String studentGender;
  late String parent1Name;
  late String parent1PhoneNumber;
  late String parent1EmailId;
  late String parent2Name;
  late String parent2PhoneNumber;
  late String parent2EmailId;
  late String studentPhotoURL;
  late String zone;
  late String active;
  late Timestamp timestamp;

  StudentModel(
      {this.studentId = 'NA',
        this.studentName = 'NA',
        this.studentDOB = 'NA',
        this.studentGender = 'NA',
        this.parent1Name = 'NA',
        this.parent1PhoneNumber = 'NA',
        this.parent1EmailId = 'NA',
        this.parent2Name = 'NA',
        this.parent2PhoneNumber = 'NA',
        this.parent2EmailId = 'NA',
        this.studentPhotoURL = 'NA',
        this.zone = 'NA',
        this.active = 'NA',
        required this.timestamp ,
      });

  factory StudentModel.fromDocument(DocumentSnapshot doc) {
    return StudentModel(
      studentId: doc.id,
      studentName: doc['studentName'],
      studentDOB: doc['studentDOB'],
      studentGender: doc['studentGender'],
      parent1Name: doc['parent1Name'],
      parent1PhoneNumber: doc['parent1PhoneNumber'],
      parent1EmailId: doc['parent1EmailId'],
      parent2Name: doc['parent2Name'],
      parent2PhoneNumber: doc['parent2PhoneNumber'],
      parent2EmailId: doc['parent2EmailId'],
      studentPhotoURL: doc['studentPhotoURL'],
      zone: doc['zone'],
      active: doc['active'],
      timestamp: doc['timestamp'],
    );
  }

}