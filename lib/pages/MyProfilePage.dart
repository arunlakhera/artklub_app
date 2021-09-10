import 'package:artklub/model/StudentModel.dart';
import 'package:artklub/pages/EditMyProfilePage.dart';
import 'package:artklub/services/AuthenticationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  late String studentId;
  late StudentModel studentData = StudentModel(timestamp: Timestamp.now());

  TextStyle textStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'Quicksand',
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    setState(()  {
      studentId = AuthenticationService().getUser()!.uid;

    });
    getData();
    super.initState();
  }

  getData() async{

    FirebaseFirestore.instance
        .collection('students')
        .doc(studentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {

      if (documentSnapshot.exists) {
        setState(() {
          studentData = StudentModel.fromDocument(documentSnapshot);
        });

      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    getData();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: (studentData.studentPhotoURL == 'NA' || studentData.studentPhotoURL.isEmpty) ?
                      CircleAvatar(
                        backgroundColor: Colors.yellow.shade100,
                        child: Icon(
                          Icons.perm_contact_cal,
                          size: 70,
                          color: Colors.green,
                        ),
                      ) :
                      Image.network(
                        studentData.studentPhotoURL,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 5,right: 10,
                      child: FloatingActionButton(
                        elevation: 5,
                        backgroundColor: Colors.green.shade400,
                        onPressed: () async {
                          await studentData;
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.leftToRight,
                              child: EditMyProfilePage(studentSelected: studentData),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Student Details',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 5),

                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          studentData.studentName,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),

                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Date of Birth',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          studentData.studentDOB,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          studentData.studentGender,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Parent 1 Details',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                SizedBox(height: 5),

                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          studentData.parent1Name,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          studentData.parent1PhoneNumber,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Email Id',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          studentData.parent1EmailId,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Parent 2 Details',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          studentData.parent2Name,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          studentData.parent2PhoneNumber,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Email Id',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          studentData.parent2EmailId,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }



}
