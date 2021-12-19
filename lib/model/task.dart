import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    this.id,
    this.date,
    this.category,
    this.description,
    this.title,
    this.status,
    this.userId,
    this.attendes,
    this.completed
  });

  String? id;
  Timestamp? date;
  String? category;
  String? description;
  String? title;
  String? status;
  String? userId;
  List? attendes;
  bool? completed = false;
  //List<Attende>? attendes;

  factory Task.fromJson(DocumentSnapshot doc){
    return Task(
        id: doc["id"],
        date: doc["date"],
        category: doc["category"],
        description: doc["description"],
        title: doc["title"],
        status: doc["status"],
        userId: doc["userId"],
        attendes: doc["attendes"],
        completed: doc["completed"]
      //attendes: List<Attende>.from(json["attendes"].map((x) => Attende.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    'date': date ?? FieldValue.serverTimestamp(),
    "category": category,
    "description": description,
    "title": title,
    "userId": userId,
    "status": status,
    "attendes": List<dynamic>.from(attendes!.map((x) => x.toJson())),
    "completed": completed
  };
}

class Attende {
  Attende({
    this.uid,
  });

  String? uid;

  factory Attende.fromJson(Map<String, dynamic> json) => Attende(
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
  };
}
