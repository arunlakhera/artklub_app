import 'dart:io';

import 'package:artklub/model/StudentModel.dart';
import 'package:artklub/services/AuthenticationService.dart';
import 'package:artklub/utilities/AppColors.dart';
import 'package:custom_picker/custom_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditMyProfilePage extends StatefulWidget {
  final StudentModel studentSelected;

  const EditMyProfilePage({Key? key, required this.studentSelected})
      : super(key: key);

  @override
  _EditMyProfilePageState createState() => _EditMyProfilePageState();
}

class _EditMyProfilePageState extends State<EditMyProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File? _image;

  var opt;
  var monthList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  bool _isSubmitting = false;

  late String _studentId,
      _studentName,
      _studentDOB,
      _studentGender,
      _parent1Name,
      _parent1PhoneNumber,
      _parent1EmailId,
      _parent2Name,
      _parent2PhoneNumber,
      _parent2EmailId,
      _studentPhotoURL;

  @override
  void initState() {
    setState(() {
      _studentId = widget.studentSelected.studentId;
      _studentName = widget.studentSelected.studentName;
      _studentGender = widget.studentSelected.studentGender;

      opt = [5, 17, 3];
      _parent1Name = widget.studentSelected.parent1Name;
      _parent1PhoneNumber = widget.studentSelected.parent1PhoneNumber;
      _parent1EmailId = widget.studentSelected.parent1EmailId;
      _parent2Name = widget.studentSelected.parent2Name;
      _parent2PhoneNumber = widget.studentSelected.parent2PhoneNumber;
      _parent2EmailId = widget.studentSelected.parent2EmailId;
      _studentPhotoURL = widget.studentSelected.studentPhotoURL;

    });

    var mm = monthList[opt[0]].toString();
    var dd = (opt[1] + 1).toString();
    var yy = (DateTime.now().year - opt[2]).toString();
    _studentDOB = dd + '-' + mm + '-' + yy;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.pageBgColor,
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'Edit My Profile',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
          ),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _isSubmitting = true;
              });
              _submitRequest();
            },
            icon: Icon(
              Icons.save,
            ),
            label: Text('Save'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green.shade200,
              shadowColor: Colors.greenAccent,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child:
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: (_studentPhotoURL == 'NA' && _image == null)  ?
                        CircleAvatar(
                          radius: 66,
                          backgroundColor: Colors.green.shade100,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.green.shade100,
                          ),
                        ):
                        (_image == null) ? CircleAvatar(
                          radius: 66,
                          backgroundColor: Colors.green.shade100,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.green.shade100,
                            backgroundImage: NetworkImage(_studentPhotoURL),
                          ),
                        ) :
                        CircleAvatar(
                          radius: 66,
                          backgroundColor: Colors.green.shade100,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.green.shade100,
                            backgroundImage:
                            _image == null ? null : FileImage(_image!),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showChoiceDialog(context);
                        },
                        icon: Icon(
                          Icons.camera_alt,
                        ),
                        label: Text('Select Photo'),
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          primary: Colors.green,
                          shadowColor: Colors.greenAccent,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Student Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            _buildStudentNameInput(),
                            SizedBox(height: 10),
                            _buildStudentDOB(screenHeight, screenWidth),
                            SizedBox(height: 10),
                            _buildStudentGender(screenHeight, screenWidth),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Parent 1 Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            _buildParent1Name(),
                            SizedBox(height: 2),
                            _buildParent1PhoneNumber(),
                            SizedBox(height: 2),
                            _buildParen1Email(),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Parent 2 Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            _buildParent2Name(),
                            SizedBox(height: 2),
                            _buildParent2Phone(),
                            SizedBox(height: 2),
                            _buildParent2Email(),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget openDatePicker() {
    var now = new DateTime.now();

    return CustomPicker(
      // deciding list whether to show loop over popup items
      optionLoop: [false, false, false],
      // give popup height
      popupHeight: MediaQuery.of(context).size.height * 0.3,
      // where to show popupmenu
      below: true,
      // give where to place popup vertically
      verticalOffset: 10,
      // handle all changes here
      handleChange: (list) {
        print(list);
      },
      // to include yes no dialog or not
      yesNo: true,
      //give color to popup selected option
      popUpSelColor: Colors.green.withAlpha(50),
      // customize text style for each popUp list
      popUpTextStyle: [
        TextStyle(color: Colors.grey.shade600, fontSize: 18),
        TextStyle(color: Colors.grey.shade600, fontSize: 18),
        TextStyle(color: Colors.grey.shade600, fontSize: 18),
      ],
      // customize text style for each list
      widTextStyle: [
        TextStyle(color: Colors.white, fontSize: 18),
        TextStyle(color: Colors.white, fontSize: 18),
        TextStyle(color: Colors.white, fontSize: 18),
      ],
      // customize divider color
      divColor: Colors.grey.shade200,
      //add padding
      contentPadding: const EdgeInsets.all(7),
      //give a decoration to your popupmenu
      popUpDecoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: const Color(0x33000000).withAlpha(50),
            offset: Offset(2, 4),
            blurRadius: 7,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      // decorate your picker widget
      widDecoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: const Color(0x33000000).withAlpha(50),
            offset: Offset(2, 4),
            blurRadius: 7,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      // input all list you want to display in popupmenu
      list: [
        monthList,
        List.generate(31, (index) => '${index + 1}').toList(),
        List.generate(100, (index) => '${now.year - index}').toList(),
      ],
      // control flex property of picker children
      wtList: [3, 1, 2],
      // callback that'll be call when option of YesNo dialog is clicked
      onChanged: (List<int> value) {
        opt = value;
        var mm = monthList[opt[0]].toString();
        var dd = (opt[1] + 1).toString();
        var yy = (now.year - opt[2]).toString();
        _studentDOB = dd + '-' + mm + '-' + yy;
        setState(() {
          print('Selected Date:' + _studentDOB);
        });
      },
      //give initial selected item indicies
      selected: opt,
    );
  }

  _buildStudentNameInput() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (val) => _studentName = val!,
      initialValue: _studentName,
      validator: (val) => val!.isEmpty ? "Please provide student name" : null,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.account_circle,
          color: Colors.green.shade600,
        ),
        filled: true,
        labelText: 'Name',
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey,
        ),
        hintText: 'Enter Student Name',
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  _buildStudentDOB(screenHeight, screenWidth) {
    return Container(
      height: screenHeight * 0.1,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 5),
            child: Text(
              'Date of Birth',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          openDatePicker(),
        ],
      ),
    );
  }

  _buildStudentGender(double screenHeight, double screenWidth) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 5, top: 5),
            child: Text(
              'Student is a...',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _studentGender = 'boy';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: _studentGender == 'boy'
                        ? Colors.green.shade600
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.male,
                        size: screenHeight * 0.04,
                        color: Colors.white,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Boy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _studentGender = 'girl';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: _studentGender == 'girl'
                        ? Colors.green.shade600
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.female,
                        size: screenHeight * 0.04,
                        color: Colors.white,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Girl',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildParent1Name() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (val) => _parent1Name = val!,
      initialValue: _parent1Name,
      validator: (val) => val!.isEmpty ? "Please provide parent 1 name" : null,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.account_circle,
          color: Colors.green.shade600,
        ),
        filled: true,
        labelText: 'Name',
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey,
        ),
        hintText: 'Enter Parent 1 Name',
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  _buildParent1PhoneNumber() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      maxLength: 10,
      initialValue: _parent1PhoneNumber,
      onSaved: (val) => _parent1PhoneNumber = val!,
      validator: (val) => val!.isEmpty ? "Please provide parent 1 phone" : null,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.green.shade600,
        ),
        filled: true,
        labelText: 'Phone',
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey,
        ),
        hintText: 'Enter Parent 1 Phone',
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  _buildParen1Email() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      initialValue: _parent1EmailId,
      onSaved: (val) => _parent1EmailId = val!,
      validator: (val) =>
          (val!.isEmpty || (!val.contains('@') && !val.contains('.')))
              ? "Please provide parent 1 email Id"
              : null,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.green.shade600,
        ),
        filled: true,
        labelText: 'Email',
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey,
        ),
        hintText: 'Enter Parent 1 Email',
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  _buildParent2Name() {
    return TextFormField(
      keyboardType: TextInputType.name,
      initialValue: _parent2Name,
      onSaved: (val) => _parent2Name = val!,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.account_circle,
          color: Colors.green.shade600,
        ),
        filled: true,
        labelText: 'Name',
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey,
        ),
        hintText: 'Enter Parent 2 Name',
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  _buildParent2Phone() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      maxLength: 10,
      initialValue: _parent2PhoneNumber,
      onSaved: (val) => _parent2PhoneNumber = val!,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.green.shade600,
        ),
        filled: true,
        labelText: 'Phone',
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey,
        ),
        hintText: 'Enter Parent 2 Phone Number',
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  _buildParent2Email() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      initialValue: _parent2EmailId,
      onSaved: (val) => _parent2EmailId = val!,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.green.shade600,
        ),
        filled: true,
        labelText: 'Email',
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey,
        ),
        hintText: 'Enter Parent 2 Email',
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  _submitRequest() {
    final _form = _formKey.currentState;
    if (_form!.validate()) {
      _form.save();
      _updateStudentData();
    } else {
      print("Form is Invalid");
    }
  }

  _updateStudentData() async {
    setState(() {
      _isSubmitting = true;
      EasyLoading.show(status: 'Updating...');
    });

    if (_image != null){
      _studentPhotoURL = await _uploadPhoto(_image);
    }

    await AuthenticationService()
        .updateStudent(
            _studentId,
            _studentName,
            _studentDOB,
            _studentGender,
            _parent1Name,
            _parent1PhoneNumber,
            _parent1EmailId,
            _parent2Name.isEmpty ? 'NA' : _parent2Name,
            _parent2PhoneNumber.isEmpty ? 'NA' : _parent2PhoneNumber,
            _parent2EmailId.isEmpty ? 'NA' : _parent2EmailId,
            _studentPhotoURL.isEmpty ? 'NA' : _studentPhotoURL)
        .then((result) {
      if (result == 'update_success') {

        Alert(
          context: context,
          type: AlertType.success,
          title: "Save",
          desc: "Your details have been updated successfully.",
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

      } else {

        Alert(
          context: context,
          type: AlertType.error,
          title: "Save Error",
          desc: "Your details could not be saved. Please try again later.",
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
        ).show();

      }
    });

    setState(() {
      _isSubmitting = false;
      EasyLoading.dismiss();
    });
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
                    onTap: () async {

                      if (await Permission.camera.request().isGranted) {
                        // Either the permission was already granted before or the user just granted it.
                        _openGallery(context);
                        Navigator.pop(context);
                      }

                      // You can request multiple permissions at once.
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.camera,
                        Permission.storage,
                        Permission.photos,
                      ].request();


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
                    onTap: () async {

                      if (await Permission.photos.request().isGranted) {
                        // Either the permission was already granted before or the user just granted it.
                        _openCamera(context);
                        Navigator.pop(context);
                      }

                      // You can request multiple permissions at once.
                      Map<Permission, PermissionStatus> statuses = await [
                      Permission.camera,
                          Permission.storage,
                      Permission.photos,
                      ].request();

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

    if (_studentImage == null) return 'NA';

    try{
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_photo')
          .child(widget.studentSelected.studentId + '.jpg');

      await ref.putFile(_studentImage!);

      _studentPhotoURL = await ref.getDownloadURL();

    }on FirebaseException catch (e){
      print(e.message);
    }

    return _studentPhotoURL;
  }
}
