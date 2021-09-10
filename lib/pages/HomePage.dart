
import 'package:artklub/model/StudentModel.dart';
import 'package:artklub/pages/CoursesPage.dart';
import 'package:artklub/pages/LoginPage.dart';
import 'package:artklub/pages/MyCoursesPage.dart';
import 'package:artklub/pages/MyProfilePage.dart';
import 'package:artklub/pages/NotificationsPage.dart';
import 'package:artklub/pages/PaymentPage.dart';
import 'package:artklub/services/AuthenticationService.dart';
import 'package:artklub/utilities/AppColors.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  var _selectedIndex= 0;
  late String studentId;
  Color activeColor = Colors.green;
  String activeTitle = 'Home';

  late FancyDrawerController _controller;
  late StudentModel studentData = StudentModel(timestamp: Timestamp.now());

  @override
  void initState() {

    setState(() {
      studentId = AuthenticationService().getUser()!.uid;
      getData();
    });

    super.initState();

    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {
        }); // Must call setState
      });

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    getData();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      child: FancyDrawerWrapper(
        backgroundColor: Colors.white,
        controller: _controller,
        drawerItems: showMenu(screenWidth),

        child: Scaffold(
          appBar: buildAppBar(screenHeight, screenWidth),
          bottomNavigationBar: buildBottomBar(screenHeight, screenWidth),

          body: SafeArea(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              color: AppColors.pageBgColor,
              child: selectPage(),
            ),
          ),
        ),
      ),
    );
  }

  // App Bar Widget
  PreferredSizeWidget buildAppBar(screenHeight, screenWidth){
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: screenHeight * 0.085,
      elevation: 5,
      leading: Container(
        child: IconButton(
          onPressed: (){
            _controller.toggle();
          },
          icon: Icon(Icons.menu_rounded, color: Colors.green,),
        ),
      ),
      title: Container(
        padding: EdgeInsets.only(left: 20,right: 20, top: 5,bottom: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.green.withOpacity(0.3),
        ),
        child: Row(
          children: [
            (studentData.studentPhotoURL == 'NA') ? CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/mascot.png'),
            ) : CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(studentData.studentPhotoURL),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentData.studentName,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Visibility(
                  visible: (studentData.zone.isEmpty || studentData.zone == 'NA') ? false : true,
                  child: Text(
                    studentData.zone,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  // Bottom Bar Widget
  Widget buildBottomBar(screenHeight, screenWidth){
    return BottomNavyBar(
      backgroundColor: Colors.white,
      selectedIndex: _selectedIndex,
      containerHeight: screenHeight * 0.07,
      showElevation: true,
      items: [
        /// Home
        BottomNavyBarItem(
          icon: Icon(Icons.home,),
          title: Text("Home", style: TextStyle(fontSize: 12,),),
          activeColor: Colors.green,
        ),

        /// Likes
        BottomNavyBarItem(
          icon: Icon(Icons.article),
          title: Text("My Courses", style: TextStyle(fontSize: 12),),
          activeColor: Colors.green,
        ),

        /// Search
        BottomNavyBarItem(
          icon: Icon(Icons.notifications),
          title: Text("Notifications", style: TextStyle(fontSize: 12),),
          activeColor: Colors.green,
        ),

        /// Profile
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile", style: TextStyle(fontSize: 12),),
          activeColor: Colors.green,
        ),
      ],
      onItemSelected: (int value) {
        setState(() {
          _selectedIndex = value;
          switch(_selectedIndex){
            case 0:
              activeTitle = 'Home';
              activeColor = Colors.green;
              break;
            case 1:
              activeTitle = 'My Courses';
              activeColor = Colors.deepOrange;
              break;
            case 2:
              activeTitle = 'Notifications';
              activeColor = Colors.purple;
              break;
            case 3:
              activeTitle = 'Profile';
              activeColor = Colors.pink;
              break;
            default:
              activeTitle = 'Home';
              activeColor = Colors.green;
          }
        });
      },
    );
  }

  selectPage() {

    switch(_selectedIndex){
      case 0:
        return CoursesPage();
      case 1:
        return MyCoursesPage();
      case 2:
        return NotificationsPage();
      case 3:
        return MyProfilePage();
      default:
        return HomePage();

    }
  }

  List<Widget> showMenu(screenWidth){
    return [

      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: screenWidth * 0.2,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.shade100,
                    spreadRadius: 40,
                    blurRadius: 40,
                    offset: Offset(
                        10, 10), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/artklub_logo.png',
                width: 100,
                height: 100,
              ),
            ),
            Text(
              'Give Wings to',
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.5),
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 1.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ]),
            ),
            Text(
              'Your Imagination',
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.5),
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 1.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ]),
            ),
          ],
        ),
      ),

      GestureDetector(
        onTap: (){
          setState(() {
            _selectedIndex = 0;
          });
          _controller.close();
        },
        child: Container(
          child: Row(
            children: [
              Icon(Icons.home),
              SizedBox(width: 10),
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: (){
          setState(() {
            _selectedIndex = 1;
          });
          _controller.close();
        },
        child: Container(
          child: Row(
            children: [
              Icon(Icons.article),
              SizedBox(width: 10),
              Text(
                'My Courses',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: (){
          setState(() {
            _selectedIndex = 2;
          });
          _controller.close();
        },
        child: Container(
          child: Row(
            children: [
              Icon(Icons.notifications),
              SizedBox(width: 10),
              Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: (){
          setState(() {
            _selectedIndex = 3;
          });
          _controller.close();
        },
        child: Container(
          child: Row(
            children: [
              Icon(Icons.person),
              SizedBox(width: 10),
              Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: PaymentPage(),
            ),
          );
          _controller.close();
        },
        child: Container(
          child: Row(
            children: [
              Icon(Icons.money),
              SizedBox(width: 10),
              Text(
                'Payment',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: (){
          AuthenticationService().signOut().then((result) {
            if(result == null){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  result,
                  style: TextStyle(fontSize: 16),
                ),
              ));
            }
          });
        },
        child: Container(
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.powerOff,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),

    ];
  }

}

