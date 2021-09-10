
import 'package:artklub/model/Course.dart';
import 'package:artklub/services/AuthenticationService.dart';
import 'package:artklub/utilities/AppColors.dart';
import 'package:custom_picker/custom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JoinProgramPage extends StatefulWidget {
  final Course courseSelected;
  const JoinProgramPage({Key? key, required this.courseSelected}) : super(key: key);

  @override
  _JoinProgramPageState createState() => _JoinProgramPageState();
}

class _JoinProgramPageState extends State<JoinProgramPage> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var opt = [5, 17, 3];
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

  late String _courseName;
  late String _studentName, _studentDOB, _studentGender,_parent1Name,
      _parent1PhoneNumber, _parent1EmailId, _parent2Name, _parent2PhoneNumber,
      _parent2EmailId;

  late bool _isSubmitting = false;

  @override
  void initState() {
    _courseName = widget.courseSelected.getCourseName();
    _studentGender = 'girl';

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
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.085,
        elevation: 5,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: Container(
          padding: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.green.shade100,
          ),
          child: Text(
            'Join Program',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(bottom: screenHeight * 0.07),
                children: [
                  _buildCourse(screenHeight, screenWidth),
                  Form(
                    key: _formKey,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
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
                  ),

                ]
            ),
            _buildSendRequestButton(),

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

  _buildCourse(screenHeight, screenWidth) {
    return Card(
      color: Colors.green.shade600,
      child: Container(
        padding: EdgeInsets.only(left: 10,right: 20,top: 20,bottom:10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I want to to join as',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Image.asset(
                    'assets/images/${widget.courseSelected.getCourseName().toString().toLowerCase()}.png',
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/mascot.png',
              fit: BoxFit.fill,
              height: screenHeight * 0.1,
              width: screenWidth * 0.2,
            )
          ],
        ),
      )
    );
  }

  _buildStudentNameInput() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (val) => _studentName = val!,
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
      height: screenHeight*0.1,
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
            padding: EdgeInsets.only(left: 5,top: 5),
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
                onTap: (){
                  setState(() {
                    _studentGender = 'boy';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: _studentGender == 'boy' ? Colors.green.shade600 : Colors.grey.shade300,
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
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  setState(() {
                    _studentGender = 'girl';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: _studentGender == 'girl' ? Colors.green.shade600 : Colors.grey.shade300,
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
                            color: Colors.white
                        ),
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

      onSaved: (val) => _parent1EmailId = val!,
      validator: (val) => (val!.isEmpty || (!val.contains('@') && !val.contains('.'))) ? "Please provide parent 1 email Id" : null,
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

  _buildSendRequestButton() {
    return Positioned(
      bottom: 10,
      left: 10,
      right: 10,
      child: FloatingActionButton.extended(
        onPressed: () {
          _submitRequest();
        },
        icon: Icon(
          Icons.send,
          color: Colors.black,
        ),
        backgroundColor: Colors.green.shade100,
        label: Text(
          'Send Request',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _submitRequest() {
    final _form = _formKey.currentState;
    if (_form!.validate()) {
      _form.save();
      _sendJoinRequest();
    } else {
      print("Form is Invalid");
    }
  }

  _sendJoinRequest() async {
    setState(() {
      _isSubmitting = true;
      EasyLoading.show(status: 'Sending Request...');
    });

    await AuthenticationService().addJoinRequest(
        _courseName,
        _studentName,
        _studentDOB,
        _studentGender,
        _parent1Name,
        _parent1PhoneNumber,
        _parent1EmailId,
        _parent2Name.isEmpty ? 'NA' : _parent2Name,
        _parent2PhoneNumber.isEmpty ? 'NA' : _parent2PhoneNumber,
        _parent2EmailId.isEmpty ? 'NA' : _parent2EmailId,

    ).then((result) {
      if(result == 'join_request_success'){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Request Sent Successfully.',
                style: TextStyle(fontSize: 16),
              ),
            ));

            Navigator.pop(context);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Request could not be sent. Please try again.',
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    });

    setState(() {
      _isSubmitting = false;
      EasyLoading.dismiss();
    });
  }
}