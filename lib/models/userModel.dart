import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String? email;
  String? uid;
  UserModel({  this.email, this.uid});

  Map<String, dynamic> toJson() => {
    "email": email,
    "uid": uid,
  };
  // //returns an user obj from a document sanpshot in firestore database
  // static UserModel fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return UserModel(
  //     email: snapshot['email'],
  //     uid: snapshot['uid'],
  //
  //   );
  // }
  UserModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    if (documentSnapshot != null) {
      var snapshot = documentSnapshot.data() as Map<String, dynamic>;
      // ignore: deprecated_member_use
      uid = documentSnapshot.id;
      email = documentSnapshot['email'];
    }
  }

}
