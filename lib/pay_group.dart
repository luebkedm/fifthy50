import 'expense.dart';

class PayGroup {

  PayGroup({this.id, this.description="", this.subtext="", this.userid1=-1, this.userid2=-1, this.expensetableid});

  int id;
  final String description;
  final String subtext;
  int userid1;
  int userid2;
  String expensetableid;
  List<Expense> expenses = List<Expense>();

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'description' : description,
      'userid1' : userid1,
      'userid2' : userid2,
      'subtext': subtext,
      'expensetableid' : expensetableid
    };
  }
}