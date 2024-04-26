import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoModel {
  String content;
  String todoId;
  String head;
  DateTime? dateTime;
  DateTime? dateCreated;
  int? priority;
  bool done;

  TodoModel({
    required this.content,
    required this.todoId,
   required this.head,
    this.dateTime,
    this.dateCreated,
    this.priority,
    this.done = false,
  });

  TodoModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : content = documentSnapshot['content'] ?? '',
        todoId = documentSnapshot.id,
        head = documentSnapshot['head'],
        priority=documentSnapshot['priority'],
        // dateTime=documentSnapshot['dateTime'] as Timestamp ,
        dateTime = (documentSnapshot['dateTime'] as Timestamp?)?.toDate() ,
        dateCreated = (documentSnapshot['dateCreated'] as Timestamp?)?.toDate() ,
        // timeOfDay = documentSnapshot['timeOfDay'] != null
        //     ? TimeOfDay.fromDateTime((documentSnapshot['timeOfDay'] as Timestamp).toDate())
        //     : null,
        done = documentSnapshot['done'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "done": done,
      "priority":priority,
      if (head != null) "head": head,
      if (dateTime != null) "dateTime": dateTime,
      if (dateCreated != null) "dateTime": dateCreated,
      //if (timeOfDay != null) "timeOfDay": Timestamp.fromDate(timeOfDay!.toDateTime(DateTime.now())),
      if (priority != null) "priority": priority,
    };
  }
}
