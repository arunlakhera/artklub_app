import 'package:artklub/data/CourseData.dart';
import 'package:artklub/model/Course.dart';
import 'package:artklub/pages/CourseDetailsPage.dart';
import 'package:artklub/pages/ForgotPasswordPage.dart';
import 'package:artklub/pages/HomePage.dart';
import 'package:artklub/pages/JoinProgramPage.dart';
import 'package:artklub/pages/LoginPage.dart';
import 'package:artklub/pages/RegisterPage.dart';
import 'package:artklub/services/AuthenticationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

//1
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Course courseSelected = CourseData().courseRookie;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 2
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        // 3
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Artklub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: EasyLoading.init(),
        home: AuthenticationService().getUser() != null ? HomePage() : LoginPage(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/LoginPage':
              return PageTransition(
                child: LoginPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
                reverseDuration: Duration(seconds: 3),
              );

            case '/RegisterPage':
              return PageTransition(
                child: RegisterPage(),
                type: PageTransitionType.leftToRight,
                settings: settings,
                reverseDuration: Duration(seconds: 3),
              );

            case '/LoginPage':
              return PageTransition(
                child: LoginPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
                reverseDuration: Duration(seconds: 3),
              );

            case '/ForgotPasswordPage':
              return PageTransition(
                child: ForgotPasswordPage(),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: Duration(seconds: 3),
              );

            case '/HomePage':
              return PageTransition(
                child: HomePage(),
                type: PageTransitionType.rotate,
                settings: settings,
                reverseDuration: Duration(seconds: 3),
              );

            case '/CourseDetailsPage':
              return PageTransition(
                child: CourseDetailsPage(courseSelected: courseSelected),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: Duration(seconds: 3),
              );

            case '/JoinProgramPage':
              return PageTransition(
                child: JoinProgramPage(courseSelected: courseSelected),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: Duration(seconds: 3),
              );
            case '/MyAssignmentPage':
              return PageTransition(
                child: JoinProgramPage(courseSelected: courseSelected),
                type: PageTransitionType.leftToRight,
                settings: settings,
                reverseDuration: Duration(seconds: 3),
              );
            case '/EditMyProfilePage':
              return PageTransition(
                child: JoinProgramPage(courseSelected: courseSelected),
                type: PageTransitionType.leftToRight,
                settings: settings,
                reverseDuration: Duration(seconds: 3),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
