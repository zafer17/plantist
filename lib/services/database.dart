import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantist/models/todoModel.dart';
import 'package:plantist/models/userModel.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
      await _firestore.collection("users").doc(uid).get();

      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addTodo(String content, String head, String uid,int priority,DateTime dateTime,DateTime dateCreated) async {
    try {
      await _firestore.collection("users").doc(uid).collection("todos").add({
        'priority':priority,
        'dateCreated':dateCreated,
        'content': content,
        'done': false,
        'head' : head,
        'dateTime':dateTime
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<TodoModel>> todoStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("todos")
        .orderBy("dateCreated")
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal =[];
      query.docs.forEach((element) {
        retVal.add(TodoModel.fromDocumentSnapshot(element));
      });
      retVal.sort((a, b) {
        int dateCompare = a.dateCreated!.compareTo(b.dateCreated!);
        if (dateCompare == 0) {
          return a.priority!.compareTo(b.priority as num);
        } else {
          return dateCompare;
        }
      });
      return retVal;
    });
  }


    Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateOne(String newcontentValue,  String newHead,String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"content": newcontentValue,'head':newHead},);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  deleteOne(String uid, String todoId) async {
    try{
      _firestore.collection("users").doc(uid).collection("todos").doc(todoId).delete();
    }
    catch(e){print(e);
    rethrow;
    }

  }
}