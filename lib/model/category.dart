import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.name,
    this.users,
  });

  String? id;
  String? name;
  List? users;

  factory Category.fromJson(DocumentSnapshot doc) {
    return Category(
      id: doc.id,
      name: doc['name'],
      users: doc["users"],
    );
  }



  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    //"users": List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}
