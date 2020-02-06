import 'package:fifty50/pay_group.dart';
import 'package:flutter/material.dart';

import 'dlgbase.dart';

class DlgAddPayGroup extends StatefulWidget {
  @override
  State createState() {
    return _DlgAddPayGroupState();
  }
}

class _DlgAddPayGroupState extends State<DlgAddPayGroup> {
  final ctrlDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DlgBase(
      heading: 'New pay group',
      child: TextField(
        controller: ctrlDescription,
        decoration: InputDecoration(labelText: 'Name or drescription'),
      ),
      onconfirm: () {
        var newPayGroup = PayGroup(description: ctrlDescription.text);
        Navigator.of(context).pop(newPayGroup);
      },
      oncancel: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    ctrlDescription.dispose();
    super.dispose();
  }

}
