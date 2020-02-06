import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import 'user.dart';

class BubbleNeumorphic extends StatelessWidget {
  BubbleNeumorphic(
      {this.user, this.description, this.amount});

  final User user;
  final String description;
  final double amount;

  @override
  Widget build(BuildContext context) {
    double bevel = 6;
    var blurOffsetUp = Offset(-4, -4);
    var blurOffsetDown = Offset(4, 8);
    var color = ThemeData.dark().backgroundColor;

    return Align(
        alignment: user.left==1 ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.all(6.0),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(bevel * 10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                colors: [
                  color.mix(Colors.black, .35),
                  color,
                  color.mix(Colors.white, .35)
                ]
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: bevel,
                  offset: blurOffsetUp,
                  color: color.mix(Colors.white, .2)
                ),
                BoxShadow(
                    blurRadius: bevel,
                    offset: blurOffsetDown,
                    color: color.mix(Colors.black, .65)
                )
              ]),
          child: Container(
            decoration: BoxDecoration(

            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              ...(user.left==1
                  ? [_buildAvatar(), _buildTextPart()]
                  : [_buildTextPart(), _buildAvatar()]),
            ]),
          ),
        ));
  }

  Widget _buildAvatar() {
    return Padding(
      padding: user.left==1 ? EdgeInsets.only(right: 8.0) : EdgeInsets.only(left: 8.0),
      child: CircleAvatar(
        child: Text(user.initial),
        backgroundColor: Colors.black38,
        foregroundColor: Colors.white70,
        maxRadius: 18,
      ),
    );
  }

  Widget _buildTextPart() {
    return Padding(
      padding: user.left==1 ?  EdgeInsets.only(right: 8) : EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment:
            user.left==1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Text(description),
          Text('${sprintf("%.02f", [amount])} \u20AC',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16))
        ],
      ),
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
