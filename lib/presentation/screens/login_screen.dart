import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/data/database_helper.dart';
import 'package:personal_expenses/logic/cubits/expenses_cubit.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: loginController,
                decoration: InputDecoration(
                  hintText: "Enter your userame",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (input){
                  if(input == "" || input==null){
                    return "please enter your username";
                  }
                  else if(input.length < 4){
                    return "your username must be at least 4 letters long";
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(height: 40, width: 100),
                child: ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        DatabaseHelper.username = loginController.text;
                        BlocProvider.of<ExpensesCubit>(context).reset();
                        Navigator.pushNamed(context, "/home-screen");
                      }
                    },
                    child: Text("LOGIN", style: TextStyle(fontSize: 20),)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
