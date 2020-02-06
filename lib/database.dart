import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'user.dart';
import 'pay_group.dart';
import 'expense.dart';
import 'dart:async';

class MyDatabase with ChangeNotifier {
  Database _db;
  static const String TABLE_USERS = 'users';
  static const String TABLE_PAYGROUPS = 'paygroups';

  // create a dummy user
  //final _dummyUser = User(name: 'dummy', initial: 'd', id: 9999);

  // data in memory -> accessible without waiting
  List<Expense> dataExpenses = List<Expense>();
  List<User> dataUsers = List<User>();
  List<PayGroup> dataPayGroups = List<PayGroup>();

  Future<void> init() async {
    var compl = Completer<void>();
    openDatabase(join(await getDatabasesPath(), 'mydb.db'), version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $TABLE_USERS(id INTEGER PRIMARY KEY, name TEXT, initial TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $TABLE_PAYGROUPS(id INTEGER, description TEXT, subtext TEXT, userid1 INTEGER, userid2 INTEGER, expensetableid STRING)');
    }).then((db) {
      _db = db;
      _dbGetPayGroups(db).then((rooms) {
        dataPayGroups = rooms;
        _dbGetAllUser(db).then((listuser) {
          dataUsers = listuser;
          notifyListeners();
        });
      });
      compl.complete();
    }).catchError((error) {
      compl.completeError(error);
    });
    return compl.future;
  }

  // ----------------------------------------------------------------------
  int addUser(User user) {
    // search free id
    int highestIDsoFar = 0;
    for (User u in dataUsers) {
      if (u.id > highestIDsoFar) {
        highestIDsoFar = u.id;
      }
    }
    user.id = highestIDsoFar + 1;
    dataUsers.add(user);
    _db.insert(TABLE_USERS, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return user.id;
  }

  User getUser(int userid) {
    for (User user in dataUsers) {
      if (user.id == userid) {
        return user;
      }
    }
    return null;
  }

  static Future<List<User>> _dbGetAllUser(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(TABLE_USERS);
    return List.generate(maps.length, (i) {
      return User(
          id: maps[i]['id'],
          name: maps[i]['name'],
          initial: maps[i]['initial']);
    });
  }

  List<User> getAllUsers() {
    return dataUsers;
  }

  // ----------------------------------------------------------------------
  void addPayGroup(PayGroup paygroup) {
    // search free id
    int highestIDsoFar = 0;
    for (PayGroup pg in dataPayGroups) {
      if (pg.id > highestIDsoFar) {
        highestIDsoFar = pg.id;
      }
    }
    paygroup.id = highestIDsoFar + 1;
    dataPayGroups.add(paygroup);

    // create db table fro expenses & link via id
    paygroup.expensetableid = 'paygroup_${paygroup.id}';
    _db
        .execute(
            'CREATE TABLE IF NOT EXISTS ${paygroup.expensetableid}(id INTEGER, userid INTEGER, description TEXT, amount REAL, date TEXT, shared INTEGER)')
        .then((_) {
      _db
          .insert(TABLE_PAYGROUPS, paygroup.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .then((_) {
        notifyListeners();
      });
    });
  }

  /**
   * just updates the database because it should already be in the internal list
   */
  void updatePayGroup(PayGroup paygroup) {
    _db
        .insert(TABLE_PAYGROUPS, paygroup.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((_) {
      for (var exp in paygroup.expenses) {
        _db.update(paygroup.expensetableid, exp.toMap(),
            where: 'id == ${exp.id}');
      }
      notifyListeners();
    });
  }

  List<PayGroup> getPayGroups() {
    return dataPayGroups;
  }

  static Future<List<PayGroup>> _dbGetPayGroups(Database db) async {
    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_PAYGROUPS).catchError((error) {});
    if (maps != null) {
      var list = List.generate(maps.length, (i) {
        return PayGroup(
            id: maps[i]['id'],
            userid1: maps[i]['userid1'],
            userid2: maps[i]['userid2'],
            description: maps[i]['description'],
            subtext: maps[i]['subtext'],
            expensetableid: maps[i]['expensetableid']);
      });
      for (PayGroup p in list) {
        final List<Map<String, dynamic>> mapsExp =
            await db.query(p.expensetableid).catchError((error) {});
        p.expenses = List.generate(mapsExp.length, (i) {
          return Expense(
            id: mapsExp[i]['id'],
            userid: mapsExp[i]['userid'],
            description: mapsExp[i]['description'],
            amount: mapsExp[i]['amount'],
            date: mapsExp[i]['date'],
            shared: mapsExp[i]['shared'],
          );
        });
      }
      return list;
    } else {
      return List<PayGroup>();
    }
  }
}
