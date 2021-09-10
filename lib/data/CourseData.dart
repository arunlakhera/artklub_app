
import 'package:artklub/model/Course.dart';
import 'package:artklub/utilities/AppColors.dart';

class CourseData{
  Course courseRookie = Course(
    courseNum: '01',
    courseName: 'Rookie',
    courseDesc: 'This level Stimulates the students perspective towards art. Once the student practices the techniques and when they come to a level of ease they begin to feel an urge to create more often.',
    courseMedium: 'Oil Pastel',
    courseDuration: '12 to 16 Classes \n(2 hour duration each)',
    bgImage: 'base_green.png',
    cNumImage: 'num_1.png',
    bgColor: AppColors.rookieColor,
  );

  Course courseImaginator = Course(
    courseNum: '02',
    courseName: 'Imaginator',
    courseDesc: 'This level Broadens the imagination skills and gives the student confidence to observe and reach out for the right tools and techniques to execute their imagination.',
    courseMedium: 'Oil Pastel',
    courseDuration: '12 to 16 Classes \n(2 hour duration each)',
    bgImage: 'base_yellow.png',
    cNumImage: 'num_2.png',
    bgColor: AppColors.imaginatorColor,
  );

  Course courseInnovator = Course(
    courseNum: '03',
    courseName: 'Innovator',
    courseDesc: 'This level encourages a love of art, learning and innovation! Students learn as they explore art and the creative process of taking ideas from within and bringing them into existence.',
    courseMedium: 'Poster Colours',
    courseDuration: '12 to 16 Classes \n(2 hour duration each)',
    bgImage: 'base_orange.png',
    cNumImage: 'num_3.png',
    bgColor: AppColors.innovatorColor,
  );

  Course courseDexter = Course(
    courseNum: '04',
    courseName: 'Dexter',
    courseDesc: 'Bringing an animal to life is both joyful and powerful. This level will enhance the students ability to develop and execute paintings that will bring animals to "life". The student will leave with a better awareness and understanding, while building a deeper appreciation of ways to breathe spirit and personality into the characters that populate.',
    courseMedium: 'Acrylic Colours',
    courseDuration: '16 to 20 Classes \n(2 hour duration each)',
    bgImage: 'base_blue.png',
    cNumImage: 'num_4.png',
    bgColor: AppColors.dexterColor,
  );

  Course courseAdept = Course(
    courseNum: '05',
    courseName: 'Adept',
    courseDesc: 'Our teachers nurture the passion of the students during this level imparting confidence and knowledge to draw human figures. Understanding and learning to sketch the human anatomy along with the portrait drawing learning will help the students improve and Sketch the humans better with ample creativity.',
    courseMedium: 'Oil Pastel ',
    courseDuration: '16 to 20 Classes \n(2 hour duration each)',
    bgImage: 'base_torquise.png',
    cNumImage: 'num_5.png',
    bgColor: AppColors.adeptColor,
  );
}