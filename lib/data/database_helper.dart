import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'expense_model.dart';


final CollectionReference users = FirebaseFirestore.instance.collection("users");

class DatabaseHelper{

  static String? username;


  static Future<void> addExpense(Expense data) async{
    DocumentReference expenses = users.doc(username).collection("expenses").doc();

    await expenses.set(data.toJson());

  }


  static Future<QuerySnapshot> fetchExpenses({String? order}) async{

    switch(order){
      case "dateAdded":
        return users.doc(username).collection("expenses").orderBy("dateAdded", descending: true).get();
      case "date":
        return users.doc(username).collection("expenses").orderBy("date", descending: true).get();
      case "amount":
        return users.doc(username).collection("expenses").orderBy("expenseAmount", descending: true).get();
      default:
        return users.doc(username).collection("expenses").orderBy("dateAdded", descending: true).get();
    }

  }

  static Future<void> deleteExpense(String ID) async{
    users.doc(username).collection("expenses").doc(ID).delete();
  }


  static Future<void> updateExpense({String? ID, Expense? data}) async{
    users.doc(username).collection("expenses").doc(ID).update(
        data!.toJsonUpdate()
    );
  }

}