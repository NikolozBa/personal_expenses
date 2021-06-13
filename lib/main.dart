import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/logic/cubits/expenses_cubit.dart';
import 'package:personal_expenses/presentation/router/route_generator.dart';
import 'package:personal_expenses/presentation/screens/add_expense_screen.dart';
import 'package:personal_expenses/presentation/screens/details_screen.dart';
import 'package:personal_expenses/presentation/screens/home_screen.dart';
import 'package:personal_expenses/presentation/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> ExpensesCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}


