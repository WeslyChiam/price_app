import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class deleteAlert extends StatefulWidget {
  final String pid;
  final String name;
  deleteAlert(this.pid, this.name);

  @override
  State<deleteAlert> createState() => _deleteAlertState();
}

class _deleteAlertState extends State<deleteAlert> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool auth = false;

  _fetchAuth() async {
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      setState(() {
        auth = value.data()!['authority'];
      });
    });
  }

  Future addTrack(String pid, String uid, String date, bool approve) async {
    String id = 'DELETE' + pid + date;
    DocumentReference track =
        FirebaseFirestore.instance.collection('tracks').doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      track.set({
        'id': id,
        'pid': pid,
        'wroteBy': uid,
        'date': date,
        'action': 'DELETE',
        'approve': approve,
      });
    });
  }

  Future deleteProduct(String pid) async {
    CollectionReference product =
        FirebaseFirestore.instance.collection('products');
    product.doc(pid).delete().then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Succesfully remove')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String pid = widget.pid;
    return AlertDialog(
      title: Text('Delete $name?'),
      content: Text(
          "This action will remove ${widget.name} from database. Doing so, there is no returning back\nAre you sure?"),
      actions: <Widget>[
        TextButton.icon(
            onPressed: () async {
              DateTime now = DateTime.now();
              String date = now.day.toString() +
                  '/' +
                  now.month.toString() +
                  '/' +
                  now.year.toString();
              if (auth == true) {
                await addTrack(pid, uid, date, true);
                await deleteProduct(pid);
              } else {
                await addTrack(pid, uid, date, false);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Your request is now pending')));
              }
            },
            icon: const Icon(Icons.check_outlined),
            label: const Text('Yes')),
        TextButton.icon(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Cancel'))
      ],
    );
  }
}
