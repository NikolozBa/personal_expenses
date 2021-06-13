import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/data/database_helper.dart';
import 'package:personal_expenses/logic/cubits/expenses_cubit.dart';
import 'package:personal_expenses/presentation/widgets/delete_button.dart';

class DetailsScreen extends StatelessWidget {
  final QueryDocumentSnapshot expense;
  const DetailsScreen({Key? key, required this.expense}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(expense["title"]),
        centerTitle: true,
        actions: [
          DeleteButton(ID: expense.id,)
        ],
      ),
      body: Column(
        children: [
          Text(expense.id.toString()),
        ],
      ),
    );
  }
}
