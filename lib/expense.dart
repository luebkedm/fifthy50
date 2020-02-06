class Expense {
  Expense({this.id, this.userid, this.description, this.amount, this.date, this.shared});

  final int id;
  final int userid;
  final String description;
  final double amount;
  final String date;
  final int shared;

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'userid' : userid,
      'description' : description,
      'amount' : amount,
      'date' : date,
      'shared' : shared
    };
  }
}