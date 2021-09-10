import 'package:artklub/model/Course.dart';
import 'package:artklub/pages/JoinProgramPage.dart';
import 'package:artklub/utilities/AppColors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CourseDetailsPage extends StatelessWidget {
  final Course courseSelected;

  const CourseDetailsPage({Key? key, required this.courseSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    List<String> imageList = [
      'assets/images/${courseSelected.getCourseName().toString().toLowerCase()}_img_1.png',
      'assets/images/${courseSelected.getCourseName().toString().toLowerCase()}_img_2.png',
      'assets/images/${courseSelected.getCourseName().toString().toLowerCase()}_img_3.png'
    ];
    return Scaffold(
      backgroundColor: AppColors.pageBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.085,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        elevation: 5,
        title: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.green.withOpacity(0.3),
          ),
          child: Text(
            courseSelected.getCourseName(),
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
            Container(
              margin: EdgeInsets.all(10),
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(top: screenHeight *0.001, bottom: screenHeight * 0.1),
                children: [
                  Stack(
                    children: [
                      Container(

                        padding: EdgeInsets.only(bottom: 10),
                        child: Card(
                          color: courseSelected.getbgColor(),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: screenHeight * 0.05,
                                bottom: 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Opacity(
                                  opacity: 0.6,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: Image.asset(
                                      'assets/images/${courseSelected.getcNumImage()}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Container(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Image.asset(
                                    'assets/images/${courseSelected.getCourseName().toString().toLowerCase()}.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Container(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    courseSelected.getCourseDesc(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      wordSpacing: 1,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Container(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Medium  :',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            wordSpacing: 1,
                                            fontFamily: 'Quicksand'),
                                      ),
                                      SizedBox(width: 5),
                                      Text(courseSelected.getCourseMedium(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              wordSpacing: 1,
                                              fontFamily: 'Quicksand')),
                                    ],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Container(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Duration :',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            wordSpacing: 1,
                                            fontFamily: 'Quicksand'),
                                      ),
                                      SizedBox(width: 5),
                                      Text(courseSelected.getCourseDuration(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              wordSpacing: 1,
                                              fontFamily: 'Quicksand')),
                                    ],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: screenHeight * 0.25,
                                    viewportFraction: 0.7,
                                    autoPlay: true,
                                  ),
                                  items: imageList.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(color: Colors.white),
                                          child: Card(
                                            elevation: 3,
                                            child: Image.asset(
                                              i,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: screenHeight*0.02,
                        right: screenHeight*0.02,
                        child: Image.asset(
                          'assets/images/mascot.png',
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.4,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: FloatingActionButton.extended(
                  shape: Border(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: JoinProgramPage(
                            courseSelected: this.courseSelected),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.green.shade100,
                  label: Text(
                    'Join this Course',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
}
