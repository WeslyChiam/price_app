import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/model/product_model.dart';
import 'package:price_app/model/track_model.dart';

class addRecord extends StatelessWidget {
  String id;
  addRecord(this.id);

  addProduct(
    String name,
    String price,
    String distributor,
    String material,
    String category,
    String uid,
    String date,
  ) async {
    ProductModel productModel = ProductModel();
    productModel.pid = id;
    productModel.productName = name;
    productModel.price = price;
    productModel.distributor = distributor;
    productModel.material = material;
    productModel.category = category;
    productModel.wroteBy = uid;
    productModel.date = date;
    await FirebaseFirestore.instance
        .collection("products")
        .doc(id)
        .set(productModel.toMap());
  }

  addProductWthOther(counter, String atrName, String atrDetail) async {
    ProductModelWthOther productModelWthOther = ProductModelWthOther();
    productModelWthOther.atrName = atrName;
    productModelWthOther.atrDetail = atrDetail;
    await FirebaseFirestore.instance
        .collection("products")
        .doc("$id/otherAtr/$counter")
        .set(productModelWthOther.toMap());
  }

  void copy(String id) async {
    QuerySnapshot snapshot = (await FirebaseFirestore.instance
        .collection("tracks")
        .doc(id)
        .get()) as QuerySnapshot<Object?>;
  }

  addProductFromTrack() async {
    CollectionReference tracks =
        FirebaseFirestore.instance.collection('tracks');
    ProductModel productModel = ProductModel();
    tracks.doc(id).get().then((snapshot) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      productModel.pid = data['pid'];
      productModel.productName = data['productName'];
      productModel.category = data['category'];
      productModel.price = data['price'];
      productModel.distributor = data['distributor'];
      productModel.material = data['material'];
      productModel.date = data['writtenDate'];
      productModel.wroteBy = data['wroteBy'];
      FirebaseFirestore.instance
          .collection('products')
          .doc("${data['pid']}")
          .set(productModel.toMap());
    });
  }

  addTrack(
    String pid,
    String name,
    String price,
    String distributor,
    String material,
    String category,
    String action,
    String uid,
    String date,
    bool approve,
  ) async {
    TrackModel trackModel = TrackModel();
    trackModel.id = id;
    trackModel.pid = id;
    trackModel.productName = name;
    trackModel.price = price;
    trackModel.distributor = distributor;
    trackModel.material = material;
    trackModel.category = category;
    trackModel.action = action;
    trackModel.wroteBy = uid;
    trackModel.date = date;
    trackModel.approve = approve;
    await FirebaseFirestore.instance
        .collection('tracks')
        .doc(id)
        .set(trackModel.toMap());
  }

  addTrackWthOther(counter, String atrName, String atrDetail) async {
    TrackModelWthOther trackModelWthOther = TrackModelWthOther();
    trackModelWthOther.atrName = atrName;
    trackModelWthOther.atrDetail = atrDetail;
    await FirebaseFirestore.instance
        .collection("products")
        .doc("$id/otherAtr/$counter")
        .set(trackModelWthOther.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
