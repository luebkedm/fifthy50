import 'package:flutter/material.dart';
import '../globals.dart' as globals;

/// Base class for a styled dialog
class DlgBase extends StatefulWidget {
  DlgBase({this.child, this.heading, this.onconfirm, this.oncancel});

  final String heading;
  final Widget child;
  final VoidCallback onconfirm;
  final VoidCallback oncancel;

  @override
  State createState() {
    return _DlgBaseState();
  }
}

class _DlgBaseState extends State<DlgBase> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(widget.heading, style: globals.textStyleDialogHeader),
            //-------------------
            widget.child,
            //-------------------
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Text('Confirm'),
                    onPressed: () {
                      widget.onconfirm();
                    },
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: Theme.of(context).buttonColor,
                  ),
                  MaterialButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      widget.oncancel();
                    },
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: Theme.of(context).buttonColor,
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
