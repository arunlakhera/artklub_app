import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:artklub/data/CourseData.dart';
import 'package:artklub/model/Course.dart';
import 'package:artklub/pages/CourseDetailsPage.dart';
import 'package:artklub/utilities/AppColors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

CourseData courseData = new CourseData();

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {

  PageController controller = PageController();
  var currentPageValue = 0.0;
  Color activeColor = AppColors.rookieColor;

  Course courseSelected = courseData.courseRookie;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;

      });
    });

    const colorizeColors = [
      Colors.white,
      AppColors.rookieColor,
      Colors.white,
      AppColors.dexterColor,
      Colors.white,
      AppColors.imaginatorColor,
      Colors.white,
      AppColors.innovatorColor,
      Colors.white,
      AppColors.adeptColor,
    ];

    const colorizeTextStyle = TextStyle(
        fontSize: 16.0,
        fontFamily: 'Horizon',
        fontWeight: FontWeight.bold,

    );

    return Scaffold(
      body: SafeArea(
        child:
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
              color: activeColor.withOpacity(0.7),
              width: screenWidth,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Welcome',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Give Wings To Your Imagination',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  )
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),

            PageView.builder(
              controller: controller,
              onPageChanged: changeColor,
              itemBuilder: (context, position) {

                if(position == 0){
                  return Transform(
                    transform: Matrix4.identity()..rotateX(currentPageValue - position),
                    child: buildCourseWidget(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      courseSelected: courseData.courseRookie,
                    ),
                  );
                }else if (position == 1){
                  return
                    Transform(
                      transform: Matrix4.identity()..rotateX(currentPageValue - position),
                      child: buildCourseWidget(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        courseSelected: courseData.courseImaginator,
                      ),
                    );
                }else if(position == 2){
                  return Transform(
                    transform: Matrix4.identity()..rotateX(currentPageValue - position),
                    child: buildCourseWidget(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      courseSelected: courseData.courseInnovator,
                    ),
                  );
                }else if(position == 3){
                  return Transform(
                    transform: Matrix4.identity()..rotateX(currentPageValue - position),
                    child: buildCourseWidget(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      courseSelected: courseData.courseDexter,
                    ),
                  );
                }else {
                  return Transform(
                    transform: Matrix4.identity()..rotateX(currentPageValue - position),
                    child: buildCourseWidget(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      courseSelected: courseData.courseAdept,
                    ),
                  );
                }

              },
              itemCount: 5,
            ),

            Positioned(
              bottom: screenHeight * 0.05,
              width: screenWidth,
              child: Align(
                alignment: Alignment.center,
                child: DotsIndicator(
                  dotsCount: 5,
                  position: currentPageValue,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeColor: Colors.greenAccent,
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
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

  Widget buildCourseWidget(
      {screenHeight, screenWidth, courseSelected}) =>
      Center(
        child: Container(
          height: screenHeight * 0.65,
          width: screenWidth - 20,
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(

            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/${this.courseSelected.getbgImage()}'),
            ),
          ),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/${this.courseSelected.getcNumImage()}',
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.2,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/images/mascot.png',
                      height: screenHeight * 0.25,
                      width: screenWidth * .40,
                    ),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  this.courseSelected.getCourseName(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.overline,
                    shadows: [
                      Shadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 1),
                        blurRadius: 3,
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  this.courseSelected.getCourseDesc(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    wordSpacing: 3,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.07),

              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: CourseDetailsPage(courseSelected: this.courseSelected),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100,50),
                    elevation: 5,
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Know More',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void changeColor(int value) {
    setState(() {

      if(currentPageValue.floor() == 1){
        courseSelected = courseData.courseImaginator;
      }else if(currentPageValue.floor() == 2){
        courseSelected = courseData.courseInnovator;
      }else if(currentPageValue.floor() == 3){
        courseSelected = courseData.courseDexter;
      }else if(currentPageValue.floor() == 4){
        courseSelected = courseData.courseAdept;
      }else{
        courseSelected = courseData.courseRookie;
      }

      switch(value){

        case 1:
          courseSelected = courseData.courseImaginator;
          activeColor = AppColors.imaginatorColor;
          break;
        case 2:
          courseSelected = courseData.courseInnovator;
          activeColor = AppColors.innovatorColor;
          break;
        case 3:
          courseSelected = courseData.courseDexter;
          activeColor = AppColors.dexterColor;
          break;
        case 4:
          courseSelected = courseData.courseAdept;
          activeColor = AppColors.adeptColor;
          break;
        default:
          courseSelected = courseData.courseRookie;
          activeColor = AppColors.rookieColor;
          break;
      }

    });
  }
}