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
    String type,
    String category,
    List list,
    String uid,
    String date,
  ) async {
    ProductModel productModel = ProductModel();
    productModel.pid = id;
    productModel.productName = name;
    productModel.price = price;
    productModel.distributor = distributor;
    productModel.material = material;
    productModel.type = type;
    productModel.category = category;
    productModel.list = list;
    productModel.wroteBy = uid;
    productModel.date = date;
    await FirebaseFirestore.instance
        .collection("products")
        .doc(id)
        .set(productModel.toMap());
  }

  addProductWthOther(
    String name,
    String price,
    String distributor,
    String material,
    String category,
    String atrName,
    String atrDetail,
    String uid,
    String date,
  ) async {
    ProductModelWthOther productModelWthOther = ProductModelWthOther();
    productModelWthOther.pid = id;
    productModelWthOther.productName = name;
    productModelWthOther.price = price;
    productModelWthOther.distributor = distributor;
    productModelWthOther.material = material;
    productModelWthOther.category = category;
    productModelWthOther.atrName = atrName;
    productModelWthOther.atrDetail = atrDetail;
    productModelWthOther.wroteBy = uid;
    productModelWthOther.date = date;
    await FirebaseFirestore.instance
        .collection("products")
        .doc(id)
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
      productModel.type = data['type'];
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
    String type,
    String category,
    String action,
    List list,
    String uid,
    String date,
    bool approve,
  ) async {
    TrackModel trackModel = TrackModel();
    trackModel.id = id;
    trackModel.pid = pid;
    trackModel.productName = name;
    trackModel.price = price;
    trackModel.distributor = distributor;
    trackModel.material = material;
    trackModel.type = type;
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

  addTrackWthOther(
    String pid,
    String name,
    String price,
    String distributor,
    String material,
    String category,
    String atrName,
    String atrDetail,
    String action,
    String uid,
    String date,
    bool approve,
  ) async {
    TrackModelWthOther trackModelWthOther = TrackModelWthOther();
    trackModelWthOther.id = id;
    trackModelWthOther.pid = id;
    trackModelWthOther.productName = name;
    trackModelWthOther.price = price;
    trackModelWthOther.distributor = distributor;
    trackModelWthOther.material = material;
    trackModelWthOther.category = category;
    trackModelWthOther.atrName = atrName;
    trackModelWthOther.atrDetail = atrDetail;
    trackModelWthOther.action = action;
    trackModelWthOther.wroteBy = uid;
    trackModelWthOther.date = date;
    trackModelWthOther.approve = approve;

    await FirebaseFirestore.instance
        .collection("tracks")
        .doc(id)
        .set(trackModelWthOther.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
