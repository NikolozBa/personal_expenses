import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/data/database_helper.dart';
import 'package:personal_expenses/data/expense_model.dart';
import 'package:personal_expenses/logic/cubits/expenses_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  String currentOrder = "creationDate";
  final format = DateFormat("dd/MM/yy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Expenses"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 40,),
                Text("SORT BY:", style: TextStyle(fontSize: 20),),
                Divider(),
                TextButton(
                  onPressed: () {
                    currentOrder = "creationDate";
                    BlocProvider.of<ExpensesCubit>(context).reset();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Date added',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Divider(),
                TextButton(
                  onPressed: () {
                    currentOrder = "expenseDate";
                    BlocProvider.of<ExpensesCubit>(context).reset();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Expense Date',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Divider(),
                TextButton(
                  onPressed: () {
                    currentOrder = "amount";
                    BlocProvider.of<ExpensesCubit>(context).reset();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Expense amount',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Divider(),
                SizedBox(height: 50,),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<ExpensesCubit, ExpensesState>(
        listener: (context, state) {
          if (state is ExpensesError) {
            showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text("ERROR"),
                    content: Text(state.errorMessage),
                    actions: [
                      TextButton(
                        onPressed: () {
                          return Navigator.pop(context);
                        },
                        child: Text("OK"),
                      )
                    ],
                  ),
            );
          }
        },
        builder: (context, state) {
          if (state is ExpensesInitial) {
            BlocProvider.of<ExpensesCubit>(context).getExpenses(currentOrder);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpensesLoaded) {
            return ListView.builder(
              itemCount: state.expenses.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot expense = state.expenses.docs[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, "/details", arguments: expense);
                  },
                  onLongPress: () {
                    Navigator.pushNamed(
                        context, "/edit-expense", arguments: expense);
                  },
                  child: Card(
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
                                  fontSize: 25
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 15),
                            //width: double.infinity,
                            child: Text(
                              expense["description"],
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),),


                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$" + expense["amount"].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                    color: Colors.blue
                                  ),
                                ),

                                Text(
                                  format.format(DateTime.fromMillisecondsSinceEpoch(
                                      expense["expenseDate"].seconds * 1000)),
                                  style: TextStyle(
                                      fontSize: 14,
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
              },
            );
          } else
            return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add-expense");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
