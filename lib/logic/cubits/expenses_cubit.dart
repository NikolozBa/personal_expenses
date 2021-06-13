import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/data/database_helper.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());

  getExpenses(String order) async{
    try {
      var expenses = await DatabaseHelper.fetchExpenses(order);
      emit(ExpensesLoaded(expenses));
    }catch (e) {
      emit(ExpensesError("something went wrong"));
    }
  }

  reset(){
    emit(ExpensesInitial());
  }
}
