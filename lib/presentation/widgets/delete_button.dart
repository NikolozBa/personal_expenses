import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/data/database_helper.dart';
import 'package:personal_expenses/logic/cubits/expenses_cubit.dart';

class DeleteButton extends StatelessWidget {
  final String ID;
  const DeleteButton({Key? key, required this.ID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: (){
        showDialog(
          context: context,
          builder: (_)=>AlertDialog(
            title: Text("Delete this item?"),
            content: Text("Do you really want to delete this item?"),
            actions: [
              TextButton(
                onPressed: () {
                  DatabaseHelper.deleteExpense(ID);
                  Navigator.pop(context);
                  BlocProvider.of<ExpensesCubit>(context).reset();
                  Navigator.pop(context);
                },
                child: Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              ),
            ],
          ),
        );
      },
    );
  }
}
