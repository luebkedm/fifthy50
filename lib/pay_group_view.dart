import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bubble.dart';
import 'expense.dart';

//import 'bubble_neumorphic.dart';
import 'database.dart';
import 'user.dart';
import 'pay_group.dart';
import 'animback/particle_background.dart';
import 'dialogs/dlgadduser.dart';
import 'dialogs/dlgaddexpense.dart';

class PayGroupView extends StatefulWidget {
  PayGroupView({@required this.paygroup});

  final PayGroup paygroup;

  @override
  State createState() {
    return _PayGroupViewState();
  }
}

class _PayGroupViewState extends State<PayGroupView> {
  @override
  Widget build(BuildContext context) {
    var db = Provider.of<MyDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paygroup.description),
        actions: <Widget>[
          /*IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              db.deleteExpenses();
            },
            tooltip: 'Deletes all expenses from the database',
          ),*/
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (bcontext) {
                    return DlgAddUser();
                  }).then((user) {
                db.addUser(user);
              });
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ParticleBackground(),
          Consumer<MyDatabase>(builder: (context, db, _) {
            // decide which user comes on what side
            var userID1 = widget.paygroup.userid1;
            var userID2 = widget.paygroup.userid2;
            for (User u in db.getAllUsers()) {
              if (u.id == userID1) {
                u.left = 1;
              }
              if (userID2 != null) {
                if (u.id == userID2) {
                  u.left = 0;
                }
              }
            }

            var data = widget.paygroup.expenses;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                var user = db.getUser(data[index].userid);
                return Bubble(
                    user: user,
                    description: data[index].description,
                    amount: data[index].amount,
                    date: data[index].date);
              },
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (db.getAllUsers().isEmpty) {
            // check if users are available
            if (widget.paygroup.userid1 == -1 && widget.paygroup.userid2 == -1) {
              showDialog(
                  context: context,
                  builder: (bcontext) {
                    return DlgAddUser(headline: 'No user defined yet! Please define one.',);
                  }).then((user) {
                if (user != null) {
                  db.addUser(user);
                  widget.paygroup.userid1 = user.id;
                  db.updatePayGroup(widget.paygroup);
                  _showAddExpenseDlg(context, db);
                }
              });
            } else {
              _showAddExpenseDlg(context, db);
            }
          } else {
            _showAddExpenseDlg(context, db);
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(children: [
          Container(height: 50, width: 50),
          _createPaymentText(),
        ]),
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
      ),
    );
  }

  void _showAddExpenseDlg(BuildContext context, MyDatabase db) {
    showDialog(
        context: context,
        builder: (bcontext) {
          return DlgAddExpense(db.getAllUsers());
        }).then((exp) {
      if (exp != null) {
        widget.paygroup.expenses.add(exp);
        db.updatePayGroup(widget.paygroup);
      }
    });
  }

  Widget _createPaymentText() {
    return Consumer<MyDatabase>(builder: (context, db, _) {
      for (Expense ex in widget.paygroup.expenses) {
        if (ex.shared != 1) {}
      }
      return Text('Some text');
    });
  }
}
