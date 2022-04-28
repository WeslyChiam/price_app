import 'package:cloud_firestore/cloud_firestore.dart';

class addTrack {
  final String id;

  addTrack(this.id);
  CollectionReference tracks = FirebaseFirestore.instance.collection('tracks');
  CollectionReference products =
      FirebaseFirestore.instance.collection('producrs');

  Future<void> Track(
    name,
    pid,
    price,
    distributor,
    material,
    category,
    uid,
    date,
    approve,
  ) {
    return tracks.doc(id).set({
      'pid': pid,
      'id': id,
      'productName': name,
      'price': price,
      'distributor': distributor,
      'material': material,
      'category': category,
      'wroteBy': uid,
      'action': 'ADD',
      'writtenDate': date,
      'approve': approve,
    });
  }

  Future<void> TrackWthOther(
    name,
    pid,
    price,
    distributor,
    material,
    category,
    uid,
    otherAtr,
    otherDetail,
    date,
    approve,
  ) {
    tracks.doc(id).set({
      'pid': pid,
      'id': id,
      'productName': name,
      'price': price,
      'distributor': distributor,
      'material': material,
      'category': category,
      'wroteBy': uid,
      'action': 'ADD',
      'writtenDate': date,
      'approve': approve,
    });
    return FirebaseFirestore.instance
        .collection('tracks/$id/otherAtr')
        .doc('0')
        .set({
      'atrName': otherAtr,
      'atrDetail': otherDetail,
    });
  }

  Future<void> Product(
    name,
    price,
    distributor,
    material,
    category,
    uid,
    date,
  ) {
    return products.doc(id).set({
      'pid': id,
      'productName': name,
      'price': price,
      'distributor': distributor,
      'material': material,
      'category': category,
      'wroteBy': uid,
      'writtenDate': date,
    });
  }

  Future<void> ProductWthOther(
    name,
    price,
    distributor,
    material,
    category,
    uid,
    otherAtr,
    otherDetail,
    date,
    approve,
  ) {
    products.doc(id).set({
      'pid': id,
      'productName': name,
      'price': price,
      'distributor': distributor,
      'material': material,
      'category': category,
      'wroteBy': uid,
      'writtenDate': date,
    });
    return FirebaseFirestore.instance
        .collection("products/$id/otherAtr")
        .doc('0')
        .set({
      'atrName': otherAtr,
      'atrDetail': otherDetail,
    });
  }
}
