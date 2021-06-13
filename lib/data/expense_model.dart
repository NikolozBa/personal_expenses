class Expense {
  String? title;
  double? expenseAmount;
  String? description;
  DateTime? date;
  DateTime? dateAdded;

  Expense(
      {required this.title,
      required this.expenseAmount,
      required this.description,
      required this.date,
      required this.dateAdded});

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
    data['expenseAmount'] = this.expenseAmount;
    data['description'] = this.description;
    data['date'] = this.date;
    data['dateAdded'] = this.dateAdded;
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['expenseAmount'] = this.expenseAmount;
    data['description'] = this.description;
    data['date'] = this.date;
    //data['dateAdded'] = this.dateAdded;
    return data;
  }
}
