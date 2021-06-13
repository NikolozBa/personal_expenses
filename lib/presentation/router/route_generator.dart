import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/presentation/screens/add_expense_screen.dart';
import 'package:personal_expenses/presentation/screens/details_screen.dart';
import 'package:personal_expenses/presentation/screens/edit_expense_screen.dart';
import 'package:personal_expenses/presentation/screens/home_screen.dart';
import 'package:personal_expenses/presentation/screens/login_screen.dart';

class RouteGenerator{
  static Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/home-screen":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "/add-expense":
        return MaterialPageRoute(builder: (_) => AddExpense());
      case "/details-screen":
        return MaterialPageRoute(builder: (_) => DetailsScreen(expense: settings.arguments as QueryDocumentSnapshot));
      case "/edit-expense":
        return MaterialPageRoute(builder: (_) => EditExpense(expense: settings.arguments as QueryDocumentSnapshot));
    }
  }
}