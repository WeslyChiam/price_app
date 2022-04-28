import 'package:cloud_firestore/cloud_firestore.dart';

class updateTrack {
  final String id;
  updateTrack(this.id);
  CollectionReference tracks = FirebaseFirestore.instance.collection('tracks');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> Track(
    String dataType,
    String data,
    String date,
    String uid,
    bool approve,
  ) {
    tracks.doc(id).set({
      'id': id,
      'action': 'UPDATE',
      'writtenDate': date,
      'wroteBy': uid,
      'approve': approve,
    });
    if (dataType == 'price') {
      return tracks.doc(id).set({
        'price': data,
      }, SetOptions(merge: true));
    } else if (dataType == 'distributor') {
      return tracks.doc(id).set({
        'distributor': data,
      }, SetOptions(merge: true));
    } else if (dataType == 'material') {
      return tracks.doc(id).set({
        'material': data,
      }, SetOptions(merge: true));
    }
    throw Exception('ERROR');
  }

  Future<void> Product(
    String dataType,
    String data,
    String date,
    String uid,
  ) {
    products.doc(id).update({
      'writtenDate': date,
      'wroteBy': uid,
    });
    if (dataType == 'price') {
      return products.doc(id).update({
        'price': data,
      });
    } else if (dataType == 'distributor') {
      return products.doc(id).update({
        'distributor': data,
      });
    } else if (dataType == 'material') {
      return products.doc(id).update({
        'material': data,
      });
    }
    throw Exception('ERROR');
  }

  Future<void> addOtherForProduct(
    String dataType,
    String counter,
    String data,
    String date,
    String uid,
  ) {
    products.doc("$id/otherAtr/$counter").set({
      'AtrName': dataType,
      'AtrDetail': data,
    });
    return products.doc(id).update({
      'wroteBy': uid,
      'writtenDate': date,
    });
  }

  Future<void> addOtherForTrack(
    String dataType,
    String counter,
    String data,
    String date,
    String uid,
    bool approve,
  ) {
    tracks.doc(id).set({
      'id': id,
      'action': 'UPDATE',
      'writtenDate': date,
      'wroteBy': uid,
      'approve': approve,
    });
    return tracks.doc("$id/otherAtr/$counter").set({
      'AtrName': dataType,
      'AtrDetail': data,
    }, SetOptions(merge: true));
  }
}
