import 'package:cloud_firestore/cloud_firestore.dart';

class deleteRecord {
  final String id;
  deleteRecord(this.id);
  CollectionReference tracks = FirebaseFirestore.instance.collection('tracks');

  Future<void> deleteTrack() {
    return tracks.doc(id).delete();
  }
}

class removeTrack {
  final String id;
  removeTrack(this.id);
  CollectionReference tracks = FirebaseFirestore.instance.collection('tracks');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> Pending(
    String pid,
    String date,
    String uid,
    bool approve,
  ) {
    return tracks.doc(id).set({
      'id': id,
      'action': 'DELETE',
      'pid': pid,
      'writtenDate': date,
      'wroteBy': uid,
      'approve': approve,
    });
  }

  Future<void> Track() {
    return tracks.doc(id).delete();
  }

  Future<void> Product() {
    return products.doc(id).delete();
  }
}
