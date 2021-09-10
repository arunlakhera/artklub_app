
import 'package:artklub/pages/MyAssignmentPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({Key? key}) : super(key: key);

  @override
  _MyCoursesPageState createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  bool currentFlag = true;
  bool completedFlag = false;
  bool requestsFlag = false;

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            showTab(),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Card(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: MyAssignmentPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.2),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/num_1.png',
                          height: 50,
                          width: 50,
                          color: Colors.deepOrange,
                        ),
                        SizedBox(width: 30),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Rookie',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,

                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget showTab(){
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 5),
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  currentFlag = true;
                  completedFlag = false;
                  requestsFlag = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: currentFlag ? Colors.deepOrange.withOpacity(0.3) : Colors.white,
                ),
                child: Text(
                  'Current',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: currentFlag ? Colors.deepOrange : Colors.grey,
                    fontSize: currentFlag ? 16 : 14,
                    fontWeight: currentFlag ? FontWeight.w900 : FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: (){
                setState(() {
                  currentFlag = false;
                  completedFlag = true;
                  requestsFlag = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: completedFlag ? Colors.deepOrange.withOpacity(0.3) : Colors.white,
                ),
                child: Text(
                  'Completed',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: completedFlag ? Colors.deepOrange : Colors.grey,
                    fontSize: completedFlag ? 16 : 14,
                    fontWeight: completedFlag ? FontWeight.w900 : FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: (){
                setState(() {
                  currentFlag = false;
                  completedFlag = false;
                  requestsFlag = true;
                });
              },
              child: Container(
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: requestsFlag ? Colors.deepOrange.withOpacity(0.3) : Colors.white,
                ),
                child: Text(
                  'Requests',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: requestsFlag ? Colors.deepOrange : Colors.grey,
                    fontSize: requestsFlag ? 16 : 14,
                    fontWeight: requestsFlag? FontWeight.w900 : FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }


}
