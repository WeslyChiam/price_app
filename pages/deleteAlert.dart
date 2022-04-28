import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/deleteTrack.dart';

class deleteAlert extends StatefulWidget {
  final String pid;
  final String name;
  deleteAlert(this.pid, this.name);

  @override
  State<deleteAlert> createState() => _deleteAlertState();
}

class _deleteAlertState extends State<deleteAlert> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

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
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String name = widget.name;
    String pid = widget.pid;
    return FutureBuilder(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            bool auth = data['authority'];
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
                      String id = 'DELETE' + pid + date;
                      if (data['authority'] == true) {
                        // await addTrack(pid, uid, date, true);
                        await removeTrack(id).Pending(pid, date, uid, true);
                        await removeTrack(pid).Product();
                        //await deleteProduct(pid);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Succesfully remove product')));
                      } else {
                        // await addTrack(pid, uid, date, false);
                        await removeTrack(id).Pending(pid, date, uid, false);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Your request is now pending')));
                      }
                      Navigator.pop(context);
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
          return Container();
        });
  }
}
