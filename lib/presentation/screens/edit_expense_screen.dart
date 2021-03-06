import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/data/database_helper.dart';
import 'package:personal_expenses/data/expense_model.dart';
import 'package:personal_expenses/logic/cubits/expenses_cubit.dart';
import 'package:personal_expenses/presentation/widgets/delete_button.dart';

class EditExpense extends StatelessWidget {
  final QueryDocumentSnapshot expense;
  EditExpense({Key? key, required this.expense}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController expenseDate = TextEditingController();

  final format = DateFormat("dd/MM/yy");
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    title.text = expense["title"];
    amount.text = expense["amount"].toString();
    description.text = expense["description"];
    expenseDate.text = format.format(DateTime.fromMillisecondsSinceEpoch(expense["expenseDate"].seconds * 1000));


    return Scaffold(
      appBar: AppBar(
        title: Text("edit " + expense["title"]),
        centerTitle: true,
        actions: [
          DeleteButton(ID: expense.id,)
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: title,
                      decoration: InputDecoration(
                        hintText: "Expense title",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (input) {
                        if (input == "" || input == null) {
                          return "please enter expense title";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"^\d+\.?\d{0,2}"))
                      ],
                      keyboardType: TextInputType.number,
                      controller: amount,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.attach_money),
                        hintText: "Expense amount",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (input) {
                        if (input == "" || input == null) {
                          return "please enter expense amount";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: description,
                      decoration: InputDecoration(
                        hintText: "Expense description",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (input) {
                        if (input == "" || input == null) {
                          return "please enter expense description";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: DateTimeField(
                      format: format,
                      controller: expenseDate,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2030));
                      },


                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 30),
                    child: ConstrainedBox(
                      constraints:
                      BoxConstraints.tightFor(height: 40, width: 100),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {

                              DatabaseHelper.updateExpense(
                                data: Expense(
                                    title: title.text,
                                    amount: double.parse(amount.text),
                                    description: description.text,
                                    expenseDate: format.parse(expenseDate.text),
                                    creationDate: now
                                ),
                                ID: expense.id
                              );
                              BlocProvider.of<ExpensesCubit>(context).reset();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
