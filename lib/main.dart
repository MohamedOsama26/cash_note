import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cash_note/presentation/router/app_router.dart';
import 'package:onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    appRouter: AppRouter(),
    // onboardingPagesList: onboardingPagesList,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;





  const MyApp({
    Key? key,
    required this.appRouter,
    // required this.onboardingPagesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute);
  }
}


final onboardingPagesList = [
  PageModel(
    widget: Column(
      children: [
        Container(
            padding: EdgeInsets.only(bottom: 45.0),
            child: Image.asset('assets/images/facebook.png',
                color: pageImageColor)),
        Container(
            width: double.infinity,
            child: Text('SECURED BACKUP', style: pageTitleStyle)),
        Container(
          width: double.infinity,
          child: Text(
            'Keep your files in closed safe so you can\'t lose them',
            style: pageInfoStyle,
          ),
        ),
      ],
    ),
  ),
  PageModel(
    widget: Column(
      children: [
        Image.asset('assets/images/twitter.png', color: pageImageColor),
        Text('CHANGE AND RISE', style: pageTitleStyle),
        Text(
          'Give others access to any file or folder you choose',
          style: pageInfoStyle,
        )
      ],
    ),
  ),
  PageModel(
    widget: Column(
      children: [
        Image.asset('assets/images/instagram.png', color: pageImageColor),
        Text('EASY ACCESS', style: pageTitleStyle),
        Text(
          'Reach your files anytime from any devices anywhere',
          style: pageInfoStyle,
        ),
      ],
    ),
  ),
];



