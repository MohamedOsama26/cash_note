import 'package:cash_note/presentation/screens/analyzing_screen.dart';
import 'package:cash_note/presentation/screens/home_screen.dart';
import 'package:cash_note/presentation/screens/introduction.dart';
import 'package:cash_note/presentation/screens/new_itme_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
          ),
        );
      case '/newItem':
        return MaterialPageRoute(builder: (_)=>NewItemScreen());
      case '/analyzing':
        return MaterialPageRoute(builder: (_)=> AnalyzingScreen());
      case '/introduction':
        return MaterialPageRoute(builder: (_)=>Introduction());
      default:
        return null;
    }
  }
}