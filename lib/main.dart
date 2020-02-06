import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database.dart';
import 'pay_group_overview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var db = MyDatabase();
  db.init().then((_) {
    runApp(MyApp(db));
  });
}

class MyApp extends StatelessWidget {
  final MyDatabase db;

  MyApp(this.db);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyDatabase>(
        create: (_) => db,
        child: MaterialApp(
          title: 'Fifty50',
          theme: ThemeData.dark().copyWith(
              accentColor: Colors.white,
              buttonColor: Colors.white12,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepPurpleAccent)),
          home: PayGroupOverview(),
        ));
  }
}
