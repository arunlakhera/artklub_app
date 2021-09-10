import 'package:artklub/model/StudentModel.dart';
import 'package:artklub/services/AuthExceptionHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late StudentModel studentModel;

  CollectionReference studentsRef = FirebaseFirestore.instance.collection('students');
  CollectionReference joinRequestRef = FirebaseFirestore.instance.collection('joinrequest');

  getStudentsRef(){
    return studentsRef;
  }

  get user => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //SIGN UP METHOD
  Future signUp({
    required String emailId,
    required String password,
  }) async {
    try {

      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailId,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      var firebaseError = AuthExceptionHandler.handleException(e);
      return AuthExceptionHandler.generateExceptionMessage(firebaseError);
    }
  }

  //SIGN IN METHOD
  Future signIn({required String emailId, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: emailId, password: password);
      return null;
    } on FirebaseAuthException catch (e) {

      var firebaseError = AuthExceptionHandler.handleException(e);
      return AuthExceptionHandler.generateExceptionMessage(firebaseError);
    }
  }

  //Get User
  User? getUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future addStudent(String studentId,String studentName, String parent1PhoneNumber, String parent1EmailId) async{
    // Call the user's CollectionReference to add a new user
    try{
      await studentsRef.doc(studentId).set({
        'studentId': studentId,
        'studentName': studentName,
        'studentDOB': 'NA',
        'studentGender': 'NA',
        'parent1Name': 'NA',
        'parent1PhoneNumber': parent1PhoneNumber,
        'parent1EmailId': parent1EmailId,
        'parent2Name': 'NA',
        'parent2PhoneNumber': 'NA',
        'parent2EmailId': 'NA',
        'studentPhotoURL': 'NA',
        'zone':'NA',
        'active': 'yes',
        'timestamp': Timestamp.now(),
      })
          .then((value) => print('Student Added'))
          .catchError((error) => print("Failed to add user: $error"));
      return null;
    } on FirebaseException catch(e){
      return e.message;
    }
  }

  Future updateStudent(
      String studentId,
      String studentName,
      String studentDOB,
      String studentGender,
      String parent1Name,
      String parent1PhoneNumber,
      String parent1EmailId,
      String parent2Name,
      String parent2PhoneNumber,
      String parent2EmailId,
      String studentPhotoURL,
      ) async{
    var updateMessage = '';
    try{
      await studentsRef.doc(studentId).update({
        'studentName': studentName,
        'studentDOB': studentDOB,
        'studentGender': studentGender,
        'parent1Name': parent1Name,
        'parent1PhoneNumber': parent1PhoneNumber,
        'parent1EmailId': parent1EmailId,
        'parent2Name': parent2Name,
        'parent2PhoneNumber': parent2PhoneNumber,
        'parent2EmailId': parent2EmailId,
        'studentPhotoURL': studentPhotoURL,
      }).then((value){
        updateMessage = 'update_success';
      }).catchError((error){
        updateMessage = 'update_error';
      });
      return updateMessage;
    }on FirebaseException catch(e){
      return e.message;
    }
  }

  Future addJoinRequest(
      String courseName,
      String studentName,
      String studentDOB,
      String studentGender,
      String parent1Name,
      String parent1PhoneNumber,
      String parent1EmailId,
      String parent2Name,
      String parent2PhoneNumber,
      String parent2EmailId
      ) async{
    // Call the user's CollectionReference to add a new user
    var joinRequestMessage;
    try{
      await joinRequestRef
          .add({
        'courseName' : courseName,
        'studentName': studentName,
        'studentDOB': studentDOB,
        'studentGender': studentGender,
        'parent1Name': parent1Name,
        'parent1PhoneNumber': parent1PhoneNumber,
        'parent1EmailId': parent1EmailId,
        'parent2Name': parent2Name,
        'parent2PhoneNumber': parent2PhoneNumber,
        'parent2EmailId': parent2EmailId,
        'requestStatus': 'pending',
        'feeAmount' : 'NA',
        'description': 'NA',

      })
          .then((value){
        joinRequestMessage = 'join_request_success';
      }).catchError((error){
        joinRequestMessage = 'join_request_error';
      });
      return joinRequestMessage;
    } on FirebaseException catch(e){
      return e.message;
    }
  }

  Future<StudentModel> getStudentProfile(String studentId) async {
    final DocumentSnapshot doc = await studentsRef.doc(studentId).get();
    return StudentModel.fromDocument(doc);
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _firebaseAuth.signOut();

    print('signout');
  }
}
