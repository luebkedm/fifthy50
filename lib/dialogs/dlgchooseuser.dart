import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../user.dart';
import 'dlgbase.dart';
import '../database.dart';

class DlgChooseUser extends StatefulWidget {
  @override
  State createState() {
    return _DlgChooseUserState();
  }
}

class _DlgChooseUserState extends State<DlgChooseUser> {
  @override
  Widget build(BuildContext context) {
    return DlgBase(
      heading: 'Choose/Add users',
      child: Container(
        height: 100,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Consumer<MyDatabase>(builder: (_, db, __) {
            return ListView.builder(
              shrinkWrap: true,
                itemCount: db.getAllUsers().length,
                itemBuilder: (_, index) {
                  return _UserListItem(name: db.getAllUsers()[index].name);
                });
          }),
        ]),
      ),
      onconfirm: () {},
    );
  }
}

class _UserListItem extends StatelessWidget {
  _UserListItem({this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Checkbox(onChanged: (_) {}), Text(name)],
    );
  }
}
