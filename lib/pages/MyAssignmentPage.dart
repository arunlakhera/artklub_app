import 'dart:io';

import 'package:artklub/services/AuthenticationService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyAssignmentPage extends StatefulWidget {
  const MyAssignmentPage({Key? key}) : super(key: key);

  @override
  _MyAssignmentPageState createState() => _MyAssignmentPageState();
}

class _MyAssignmentPageState extends State<MyAssignmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File? _image;
  bool _isSubmitting = false;
  late String studentId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    studentId = AuthenticationService().getUser()!.uid;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.085,
        elevation: 5,
        title: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'Join Program',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: Column(
                children: [
                  Text(
                    'Assignment 1',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.green,
                    width: screenWidth * 0.09,
                    height: 2,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'This is assignment for Rookie class in which you need to draw a painting of an old man with a hat and stick. You can use your imagination for the colors.',
                    style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Text(
                  'Pending',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                )),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              height: screenHeight * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: Stack(
                children: [
                  if (_image == null)
                    Center(
                      child: Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.red,
                      ),
                    )
                  else
                    Container(
                      alignment: Alignment.center,
                      child: Image.file(
                        _image!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (await Permission.camera.request().isGranted) {
                          // Either the permission was already granted before or the user just granted it.
                          _showChoiceDialog(context);
                        }

                        // You can request multiple permissions at once.
                        Map<Permission, PermissionStatus> statuses = await [
                          Permission.camera,
                          Permission.storage,
                          Permission.photos,
                        ].request();

                      },
                      child: Text('Upload'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (_image != null) {
                    setState(() {
                      _isSubmitting = true;
                      EasyLoading.show(status: 'Updating...');
                    });
                    _uploadPhoto(_image);
                  }
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                backgroundColor: Colors.black,
                label: Text(
                  'Submit',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.green),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.green,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                      Navigator.pop(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.green,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.green,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                      Navigator.pop(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _openGallery(context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 60,
      );
      if (image == null) return null;
      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future _openCamera(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return null;
      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future _uploadPhoto(_studentImage) async {
    var _studentAssignmentURL;

    if (_studentImage == null) return 'NA';

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('assignment')
          .child(studentId + '.jpg');

      await ref.putFile(_studentImage!);
      _studentAssignmentURL = await ref.getDownloadURL();

      setState(() {
        _isSubmitting = false;
        EasyLoading.dismiss();
      });

      Alert(
        context: context,
        type: AlertType.success,
        title: "Save",
        desc: "Your Assignment have been updated successfully.",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show().then((value) => Navigator.pop(context));
    } on FirebaseException catch (e) {
      print(e.message);
    }

    return _studentAssignmentURL;
  }
}
