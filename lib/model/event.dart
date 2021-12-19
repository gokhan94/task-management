import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.completed,
    this.date,
    this.time,
    this.address
  });

  String? id;
  String? title;
  String? description;
  String? userId;
  bool? completed = false;
  String? date;
  String? time;
  String? address;

  factory Event.fromJson(DocumentSnapshot doc){
    return Event(
        id: doc['id'],
        title: doc["title"],
        description: doc["description"],
        userId: doc["userId"],
        completed: doc["completed"],
        date: doc["date"],
        time: doc['time'],
        address: doc['address']
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "userId": userId,
    "completed": completed,
    "date": date,
    "time": time,
    "address": address
  };
}