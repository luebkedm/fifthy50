import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprintf/sprintf.dart';

import 'user.dart';
import 'timehelper.dart' as TimeHelper;

class Bubble extends StatelessWidget {
  Bubble({this.user, this.description, this.amount, @required this.date});

  final User user;
  final String description;
  final double amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: user.left==1 ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 200,
        ),
        padding:
            EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
        margin: EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(_buildDateString(date), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10)),
            Row(mainAxisSize: MainAxisSize.min, children: [
              ...(user.left==1
                  ? [_buildAvatar(), _buildTextPart()]
                  : [_buildTextPart(), _buildAvatar()]),
            ]),
          ]
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            /*gradient: LinearGradient(
            colors: [Colors.white70, Colors.white30],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),*/
            color: user.left==1
                ? Colors.deepPurple.shade200
                : Colors.deepPurple.shade100,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0, offset: Offset(6, 6), color: Colors.black54)
            ]),
      ),
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding:
          user.left==1 ? EdgeInsets.only(right: 8.0) : EdgeInsets.only(left: 8.0),
      child: CircleAvatar(
        child: Text(user.initial),
        backgroundColor: Colors.deepPurple.shade50,
        foregroundColor: Colors.deepPurple,
        maxRadius: 18,
      ),
    );
  }

  Widget _buildTextPart() {
    return Padding(
      padding: user.left==1 ?  EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
      child: Column(
        crossAxisAlignment:
            user.left==1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Text(description),
          Text('${sprintf("%.02f", [amount])} \u20AC',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18))
        ],
      ),
    );
  }

  String _buildDateString(String dateFormatted) {
    var dateStored  = TimeHelper.parseDateString(dateFormatted);
    var timeNow = DateTime.now();
     var diff = timeNow.difference(dateStored);
    debugPrint('++ ${diff.inMinutes}');
    if( diff.inMinutes < 60 && diff.inMinutes >= 0) {
      return '${diff.inMinutes} minutes ago';
    } else if( diff.inHours < 24 ) {
      return '${diff.inHours} hours ago';
    } else {
      return dateFormatted;
    }
  }
}
