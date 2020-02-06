import 'package:flutter/foundation.dart';

class User {

  int id;
  String name;
  String initial;
  int left;

  User({@required this.id, @required this.name, @required this.initial, this.left=1});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name' : name,
      'initial' : initial
    };
  }
}