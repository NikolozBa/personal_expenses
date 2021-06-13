import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/data/database_helper.dart';
import 'package:personal_expenses/data/expense_model.dart';
import 'package:personal_expenses/logic/cubits/expenses_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  String? currentOrder = "dateAdded";

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
                    currentOrder = "dateAdded";
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
                    currentOrder = "date";
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
              builder: (_) => AlertDialog(
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
            BlocProvider.of<ExpensesCubit>(context).getExpenses(order: currentOrder);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpensesLoaded) {
            return ListView.builder(
              itemCount: state.expenses.docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/details-screen", arguments: state.expenses.docs[index]);
                  },
                  onLongPress: (){
                    Navigator.pushNamed(context, "/edit-expense", arguments: state.expenses.docs[index]);
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              state.expenses.docs[index]["title"],
                              style: TextStyle(
                                  fontSize: 25
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              DateTime.fromMillisecondsSinceEpoch(state.expenses.docs[index]["date"].seconds * 1000).toString(),
                              style: TextStyle(
                                  fontSize: 25
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              //state.expenses.docs[index]["dateAdded"].seconds.toString(),
                              DateTime.fromMillisecondsSinceEpoch(state.expenses.docs[index]["dateAdded"].seconds * 1000).toString(),
                              style: TextStyle(
                                  fontSize: 25
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 20),
                            child: Text(
                              state.expenses.docs[index]["expenseAmount"].toString(),
                              style: TextStyle(
                                  fontSize: 18
                              ),
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
