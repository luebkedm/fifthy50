import '../expense.dart';
import 'package:flutter/material.dart';

import '../user.dart';
import '../globals.dart' as globals;
import '../timehelper.dart' as TimeHelper;

class DlgAddExpense extends StatefulWidget {
  DlgAddExpense(this.users);

  final List<User> users;

  @override
  State createState() {
    return _DlgAddExpenseState();
  }
}

class _DlgAddExpenseState extends State<DlgAddExpense> {
  User choosenUser;
  final ctrlDescription = TextEditingController();
  final ctrlAmount = TextEditingController();
  bool bConfirmDisabled = false;

  @override
  void initState() {
    ctrlAmount.addListener(() {
      final text = ctrlAmount.text.replaceAll(',', '.');
      ctrlAmount.value = ctrlAmount.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Dialog(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("New expense", style: globals.textStyleDialogHeader),
              DropdownButton<User>(
                value: choosenUser,
                onChanged: (_user) {
                  setState(() {
                    choosenUser = _user;
                  });
                },
                items: _buildEntries(),
              ),
              TextField(
                controller: ctrlDescription,
                keyboardType: TextInputType.text,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'What?',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: ctrlAmount,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'How much?',
                      ),
                    ),
                  ),
                  Text('\u20AC', style: TextStyle(fontSize: 20)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      child: Text('Confirm'),
                      onPressed: bConfirmDisabled
                          ? null
                          : () {
                              //TODO: check values
                              var ex = Expense(
                                  userid: choosenUser.id,
                                  description: ctrlDescription.text,
                                  amount: double.parse(ctrlAmount.text),
                                  date: TimeHelper.buildDateString());
                              Navigator.of(context).pop(ex);
                            },
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      color: Theme.of(context).buttonColor,
                    ),
                    MaterialButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      color: Theme.of(context).buttonColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        //debugPrint('Back button tapped!');
        // block back button
        return;
      },
    );
  }

  List<DropdownMenuItem<User>> _buildEntries() {
    var listOut = List<DropdownMenuItem<User>>();
    for (User u in widget.users) {
      var i = DropdownMenuItem<User>(
        value: u,
        child: Text(u.name),
      );
      listOut.add(i);
    }
    return listOut;
  }

  @override
  void dispose() {
    ctrlAmount.dispose();
    ctrlDescription.dispose();
    super.dispose();
  }
}
