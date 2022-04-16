import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/addData.dart';

import 'package:price_app/model/product_model.dart';

class textFormFieldInput extends StatefulWidget {
  @override
  State<textFormFieldInput> createState() => _textFormFieldInputState();

  final String uid;
  textFormFieldInput(this.uid);
}

class _textFormFieldInputState extends State<textFormFieldInput> {
  final formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final priceNumController = TextEditingController();
  final companyTextController = TextEditingController();
  final materialTextController = TextEditingController();
  final otherTextController = TextEditingController();
  final otherDetailTextController = TextEditingController();
  String productDDValue = 'AIR';
  bool otherCategory = false;

  RegExp regex = RegExp(r'^[a-zA-Z0-9 ]{3,50}$');

  final uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference products_ref =
      FirebaseFirestore.instance.collection('products');

  @override
  void dispose() {
    nameTextController.dispose();
    priceNumController.dispose();
    companyTextController.dispose();
    materialTextController.dispose();
    otherTextController.dispose();
    otherDetailTextController.dispose();
    super.dispose();
  }

  void clearTextController() {
    nameTextController.clear();
    priceNumController.clear();
    companyTextController.clear();
    materialTextController.clear();
    otherDetailTextController.clear();
    otherTextController.clear();
  }

  postProduct(pid, date) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    ProductModel productModel = ProductModel();

    productModel.pid = pid;
    productModel.name = nameTextController.text;
    productModel.price = priceNumController.hashCode;
    productModel.category = productDDValue;
    productModel.company = companyTextController.text;
    productModel.material = materialTextController.text;
    productModel.writer = uid;
    productModel.date = date;

    await firebaseFirestore
        .collection('products')
        .doc(pid)
        .set(productModel.toMap());
  }

  // Future<void> addProduct(String pid, String date) async {
  //   DocumentReference produc_ref =
  //       FirebaseFirestore.instance.collection('products').doc(pid);
  //   return FirebaseFirestore.instance.runTransaction((transaction) async {
  //     DocumentSnapshot snapshot = await transaction.get(produc_ref);
  //     if (!snapshot.exists) {
  //       try {
  //         postProduct(pid, date);
  //       } catch (e) {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text(e.toString())));
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('This name had been used')));
  //     }
  //   }).then((value) => null);
  // }

  Widget categoryDD() {
    return DropdownButton<String>(
      value: productDDValue,
      icon: const Icon(Icons.arrow_drop_down),
      onChanged: (String? newValue) {
        setState(() {
          productDDValue = newValue!;
        });
      },
      items: <String>['AIR', 'ELEC', 'MECH', 'PIPE', 'OTHER']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget saveBtn() {
    return TextButton.icon(
        onPressed: () async {
          // DateTime now = DateTime.now();
          // String date = now.day.toString() +
          //     '/' +
          //     now.month.toString() +
          //     '/' +
          //     now.year.toString() +
          //     ' ' +
          //     now.minute.toString() +
          //     ':' +
          //     now.hour.toString();
          // String pid = productDDValue + nameTextController.text;
          // await addProduct(
          //     pid,
          //     nameTextController.text,
          //     priceNumController.hashCode,
          //     companyTextController.text,
          //     materialTextController.text,
          //     productDDValue,
          //     date);
          if (formKey != null) {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              DateTime now = DateTime.now();
              String date = now.day.toString() +
                  '/' +
                  now.month.toString() +
                  '/' +
                  now.year.toString() +
                  ' ' +
                  now.hour.toString() +
                  ':' +
                  now.minute.toString();
              String pid = productDDValue + nameTextController.text;
              FirebaseFirestore.instance
                  .runTransaction((Transaction transaction) async {
                DocumentReference<Map<String, dynamic>> reference =
                    FirebaseFirestore.instance.collection('products').doc(pid);
                FirebaseFirestore.instance.runTransaction((transaction) async {
                  DocumentSnapshot snapshot = await transaction.get(reference);
                  if (!snapshot.exists) {
                    await reference.set({
                      'pid': pid,
                      'productName': nameTextController.text,
                      'price': priceNumController.hashCode.toDouble(),
                      'distributor': companyTextController.text,
                      'material': productDDValue,
                      'wroteBy': uid,
                      'writtenDate': date,
                    });
                  }
                }).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Succesfully saved as $pid')));
                });
              });
              // await addProduct(
              //     pid,
              //     nameTextController.text,
              //     priceNumController.hashCode,
              //     companyTextController.text,
              //     materialTextController.text,
              //     productDDValue,
              //     date);
            }
          }
        },
        icon: const Icon(Icons.save),
        label: const Text('SAVE'));
  }

  Widget textFormTypeInput(dataType, enable) {
    return TextFormField(
      autofocus: false,
      enabled: enable,
      controller: dataType == 'name'
          ? nameTextController
          : dataType == 'price'
              ? priceNumController
              : dataType == 'company'
                  ? companyTextController
                  : dataType == 'material'
                      ? materialTextController
                      : dataType == 'other'
                          ? otherTextController
                          : otherDetailTextController,
      keyboardType:
          dataType == 'price' ? TextInputType.number : TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ('Name cannot be empty');
        } else if (!regex.hasMatch(value)) {
          return ('Name must be between 3 to 50 letters');
        }
        return null;
      },
      onSaved: dataType == 'name'
          ? (value) {
              nameTextController.text = value!;
            }
          : dataType == 'price'
              ? (value) {
                  priceNumController.text = value!;
                }
              : dataType == 'company'
                  ? (value) {
                      companyTextController.text = value!;
                    }
                  : dataType == 'material'
                      ? (value) {
                          materialTextController.text = value!;
                        }
                      : dataType == 'other'
                          ? (value) {
                              otherTextController.text = value!;
                            }
                          : (value) {
                              otherDetailTextController.text = value!;
                            },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(dataType == 'name'
            ? Icons.inventory
            : dataType == 'price'
                ? Icons.price_change
                : dataType == 'company'
                    ? Icons.add_business
                    : dataType == 'material'
                        ? Icons.hive
                        : dataType == 'other'
                            ? Icons.add_box
                            : Icons.add_card),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: dataType == 'name'
            ? 'Product Name'
            : dataType == 'price'
                ? 'Price(RM)'
                : dataType == 'company'
                    ? 'Distributor'
                    : dataType == 'material'
                        ? 'Material Name'
                        : dataType == 'other'
                            ? 'Other Attribute Name'
                            : 'Details',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 45.0),
            textFormTypeInput('name', true),
            const SizedBox(height: 20.0),
            textFormTypeInput('price', true),
            const SizedBox(height: 20.0),
            textFormTypeInput('company', true),
            const SizedBox(height: 20.0),
            textFormTypeInput('material', true),
            const SizedBox(height: 20.0),
            categoryDD(),
            const SizedBox(height: 20.0),
            textFormTypeInput('other', otherCategory),
            const SizedBox(height: 20.0),
            textFormTypeInput('', otherCategory),
            const SizedBox(height: 20.0),
            TextButton.icon(
                onPressed: () async {
                  DateTime now = DateTime.now();
                  String date = now.day.toString() +
                      '/' +
                      now.month.toString() +
                      '/' +
                      now.year.toString() +
                      ' ' +
                      now.hour.toString() +
                      ':' +
                      now.minute.toString();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(date)));
                  String pid = productDDValue + nameTextController.text;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(pid)));
                  if (formKey.currentState!.validate()) {
                    // await addProduct(
                    //     pid,
                    //     nameTextController.text,
                    //     priceNumController.hashCode,
                    //     companyTextController.text,
                    //     materialTextController.text,
                    //     productDDValue,
                    //     date);
                  } else {
                    if (await addProduct(
                            pid,
                            nameTextController.text,
                            priceNumController.hashCode,
                            companyTextController.text,
                            materialTextController.text,
                            productDDValue,
                            date) ==
                        true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Save as pid: $pid')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Something went wrong!')));
                    }

                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //     content: Text('Something wrong with validator')));
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('SAVE')),
          ],
        ));
  }
}
