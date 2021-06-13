class Expense {
  String? title;
  double? amount;
  String? description;
  DateTime? expenseDate;
  DateTime? creationDate;

  Expense(
      {required this.title,
      required this.amount,
      required this.description,
      required this.expenseDate,
      required this.creationDate});

  // Expense.fromJson(Map<String, dynamic> json) {
  //   title = json['title'];
  //   expenseAmount = json['expenseAmount'];
  //   description = json['description'];
  //   date = json['date'];
  //   dateAdded = json['dateAdded'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['expenseDate'] = this.expenseDate;
    data['creationDate'] = this.creationDate;
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['expenseDate'] = this.expenseDate;
    //data['creationDate'] = this.creationDate;
    return data;
  }
}
