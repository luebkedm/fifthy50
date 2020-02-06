import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database.dart';
import 'pay_group_tile.dart';
import 'dialogs/dlgaddpaygroup.dart';
import 'animback/particle_background.dart';

class PayGroupOverview extends StatefulWidget {
  @override
  State createState() {
    return _PayGroupOverviewState();
  }
}

class _PayGroupOverviewState extends State<PayGroupOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            ParticleBackground(),
            Consumer<MyDatabase>(builder: (_, db, __) {
              var data = db.getPayGroups();
              if( data.length == 0 ) {
                return Center(child: Text("Tap '+' to add a pay group"));
              } else {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      debugPrint('paygroup id ${data[index].id}');
                      return PayGroupListTile(
                          paygroup: data[index]);
                    });
              }
            }),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (bcontext) {
            return DlgAddPayGroup();
          }).then( (paygroup) {
            if( paygroup != null ) {
              var db = Provider.of<MyDatabase>(context, listen: false);
              db.addPayGroup(paygroup);
            }
          });
        },
      ),
    );
  }
}
