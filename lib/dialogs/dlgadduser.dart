import 'package:flutter/material.dart';

import '../user.dart';
import '../globals.dart' as globals;
import 'dlgbase.dart';

class DlgAddUser extends StatefulWidget {

  DlgAddUser({this.headline='New user'});

  final String headline;

  @override
  State createState() {
    return _DlgAddUserState();
  }
}

class _DlgAddUserState extends State<DlgAddUser> {
  final ctrlName = TextEditingController();
  final ctrlInitial = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DlgBase(
      heading: widget.headline,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
      TextField(
        controller: ctrlName,
        decoration: InputDecoration(labelText: 'Name?'),
      ),
          TextField(
            controller: ctrlInitial,
            decoration: InputDecoration(labelText: 'Initial Letter?'),
          ),
      ]),
      onconfirm: () {
        var u = User(
          name: ctrlName.text,
          initial: ctrlInitial.text,
        );
        Navigator.of(context).pop(u);
      },
      oncancel: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlInitial.dispose();
    super.dispose();
  }

}