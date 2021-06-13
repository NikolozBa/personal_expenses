import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/data/database_helper.dart';
import 'package:personal_expenses/logic/cubits/expenses_cubit.dart';
import 'package:personal_expenses/presentation/widgets/delete_button.dart';

class DetailsScreen extends StatelessWidget {
  final QueryDocumentSnapshot expense;
  DetailsScreen({Key? key, required this.expense}) : super(key: key);


  final format = DateFormat("dd/MM/yy");

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  expense["title"],
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 14, bottom: 34),
                //width: double.infinity,
                child: Text(
                  expense["description"],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54
                  ),

                ),),

              Divider(thickness: 2,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$" + expense["amount"].toString(),
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue
                      ),
                    ),

                    Text(
                      format.format(DateTime.fromMillisecondsSinceEpoch(
                          expense["expenseDate"].seconds * 1000)),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black45
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
