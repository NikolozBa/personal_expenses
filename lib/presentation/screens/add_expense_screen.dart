import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/data/database_helper.dart';
import 'package:personal_expenses/data/expense_model.dart';
import 'package:personal_expenses/logic/cubits/expenses_cubit.dart';

class AddExpense extends StatelessWidget {
  AddExpense({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController date = TextEditingController();

  final format = DateFormat("dd/MM/yyyy");
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    date.text = format.format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
        centerTitle: true,
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
                      controller: date,
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

                              DatabaseHelper.addExpense(
                                Expense(
                                  title: title.text,
                                  expenseAmount: double.parse(amount.text),
                                  description: description.text,
                                  date: format.parse(date.text),
                                  dateAdded: now
                                ),
                              );
                              BlocProvider.of<ExpensesCubit>(context).reset();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Add",
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
