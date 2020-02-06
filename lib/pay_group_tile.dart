import 'package:fifty50/pay_group_view.dart';
import 'package:flutter/material.dart';

import 'pay_group.dart';

class PayGroupListTile extends StatefulWidget {

  PayGroupListTile({@required this.paygroup});

  final PayGroup paygroup;

  @override
  State createState() {
    return _PayGroupListTileState();
  }
}

class _PayGroupListTileState extends State<PayGroupListTile> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          debugPrint('tapped');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return PayGroupView(paygroup: widget.paygroup);
            }
          ));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white30
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(widget.paygroup.description, style: TextStyle(fontSize: 18)),
                Text(widget.paygroup.subtext)
              ],
            ),
          ),
        ),
      );
  }
}