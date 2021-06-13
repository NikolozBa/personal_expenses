part of 'expenses_cubit.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();
}

class ExpensesInitial extends ExpensesState {
  @override
  List<Object> get props => [];
}

class ExpensesLoaded extends ExpensesState{
  final QuerySnapshot expenses;

  ExpensesLoaded(this.expenses);

  @override
  List<Object?> get props => [expenses];

}


class ExpensesError extends ExpensesState{
  final String errorMessage;

  ExpensesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
