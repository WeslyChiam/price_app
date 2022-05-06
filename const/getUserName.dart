import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class getUserName {
  final String uid;
  getUserName(this.uid);

  Future<String> getFirstName() async {
    String tmpName = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((querySnapshot) {
      return (querySnapshot.data()!['firstName']);
    });
    return tmpName;
  }

  firstName() {
    var tmpName = 'anonymous';
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      tmpName = value.data()!["firstName"];
    });
    return tmpName;
  }
}
