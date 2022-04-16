import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

class addProductPage extends StatefulWidget {
  @override
  State<addProductPage> createState() => _addProductPageState();
}

class _addProductPageState extends State<addProductPage> {
  final _formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final companyTextController = TextEditingController();
  final materialTextController = TextEditingController();
  final otherTextController = TextEditingController();
  final otherDetailController = TextEditingController();

  String productDDValue = 'AIR';
  bool otherCategory = false;

  DateTime now = DateTime.now();

  final uid = FirebaseAuth.instance.currentUser!.uid;

  List<String> pidList = [];

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  @override
  void dispose() {
    nameTextController.dispose();
    priceTextController.dispose();
    companyTextController.dispose();
    materialTextController.dispose();
    otherTextController.dispose();
    super.dispose();
  }

  void clearTextController() {
    nameTextController.clear();
    priceTextController.clear();
    companyTextController.clear();
    materialTextController.clear();
    otherTextController.clear();
  }

  Future<void> addData(pid, data, bool otherField, dateNtime) {
    if (otherField == true) {
      return products.doc(pid).set({
        'pid': pid,
        'productName': nameTextController.text,
        'price': priceTextController.text,
        'category': productDDValue,
        'company': companyTextController.text,
        'modifyName': '${data['firstName']}',
        'modifyDate': dateNtime,
      });
    } else {
      return products.doc(pid).set({
        'pid': pid,
        'productName': nameTextController.text,
        'price': priceTextController.text,
        'category': productDDValue,
        'company': companyTextController.text,
        otherTextController.text: otherDetailController.text,
        'modifyName': '${data['firstName']}',
        'modifyDate': dateNtime,
      });
    }
  }

  // getPID() {
  //   productRef.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       pidList.add(doc);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something Went Wrong, Please Try Again'),
              duration: Duration(milliseconds: 1500)));
          Navigator.pop(context);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(title: const Text('Add New Product')),
            body: Center(
                child: SingleChildScrollView(
              child: Container(
                color: white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 45.0),
                        TextFormField(
                          autofocus: false,
                          controller: nameTextController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{3,}$');
                            if (value!.isEmpty || value == null) {
                              return ('Product name cannot be empty');
                            } else if (!regex.hasMatch(value)) {
                              return ('Product name cannot be kess than 3 charactets');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            materialTextController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.inventory),
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintText: 'Product Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          autofocus: false,
                          controller: priceTextController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return ('Price cannot be empty');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            priceTextController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.price_change),
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintText: 'Price(RM)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        DropdownButton<String>(
                          value: productDDValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (String? newValue) {
                            setState(() {
                              productDDValue = newValue!;
                            });
                          },
                          items: <String>[
                            'AIR',
                            'ELEC',
                            'MECH',
                            'PIPE',
                            'Other'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          autofocus: false,
                          controller: companyTextController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{3,}$');
                            if (value!.isEmpty || value == null) {
                              return ('Company name cannot be empty');
                            } else if (!regex.hasMatch(value)) {
                              return ('Company name cannot be less than 3 characters');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            companyTextController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.add_business),
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintText: 'Distributor',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          autofocus: false,
                          controller: materialTextController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{3,}$');
                            if (value!.isEmpty || value == null) {
                              return ('Material name cannot be empty');
                            } else if (!regex.hasMatch(value)) {
                              return ('Material name cannot be kess than 3 charactets');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            materialTextController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.hive),
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintText: 'Material Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: otherCategory,
                                onChanged: (value) {
                                  setState(() {
                                    otherCategory = value ?? false;
                                  });
                                }),
                            const Text('Others'),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          enabled: otherCategory,
                          autofocus: false,
                          controller: otherTextController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{3,}$');
                            if (value!.isEmpty || value == null) {
                              return ('Specific type attribute name cannot be empty');
                            } else if (!regex.hasMatch(value)) {
                              return ('Specific type attribute name cannot be less than 3 characters');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            companyTextController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintText: 'Other Attribute',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          enabled: otherCategory,
                          autofocus: false,
                          controller: otherDetailController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{3,}$');
                            if (value!.isEmpty || value == null) {
                              return ('Specific type name cannot be empty');
                            } else if (!regex.hasMatch(value)) {
                              return ('Specific type name cannot be less than 3 characters');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            companyTextController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintText: 'Attribute Details',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextButton.icon(
                            onPressed: () async {
                              String day = now.day.toString();
                              String month = now.month.toString();
                              String year = now.year.toString();
                              String formattedDate =
                                  day + '/' + month + '/' + year;

                              String hour = now.hour.toString();
                              String min = now.minute.toString();
                              String formattedTime = hour + ':' + min;

                              String dateNtime = formattedTime + formattedDate;

                              String pid =
                                  productDDValue + nameTextController.text;

                              FirebaseFirestore firebaseFirestore =
                                  FirebaseFirestore.instance;
                              if (_formKey.currentState!.validate()) {
                                addData(pid, data, otherCategory, dateNtime);
                                final snapshot = await FirebaseFirestore
                                    .instance
                                    .collection('products')
                                    .doc(pid)
                                    .get();

                                if (snapshot == null || !snapshot.exists) {
                                  addData(pid, data, otherCategory, dateNtime);
                                } else {
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('Oops!!!'),
                                            content: Text(
                                                'Name ${nameTextController.text} has already been used, please try another name.'),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () {
                                                    nameTextController.clear();
                                                  },
                                                  child: const Text('OK'))
                                            ],
                                          ));
                                }

                                var tmpPid = products.doc(pid);
                                firebaseFirestore
                                    .collection('products')
                                    .doc(pid)
                                    .set({
                                  'pid': pid,
                                  'productName': nameTextController.text,
                                  'price': priceTextController.text,
                                  'category': productDDValue,
                                  'company': companyTextController.text,
                                  'modifyName': '${data['firstName']}',
                                  'modifyDate': dateNtime,
                                });

                                // StreamBuilder<QuerySnapshot>(
                                //   stream: products
                                //       .where('pid', isEqualTo: pid)
                                //       .snapshots(),
                                //   builder: (context, snapshot) {
                                //     if (snapshot.hasData) {
                                //       return AlertDialog(
                                //         title: const Text('Error!'),
                                //         content: Text(
                                //             'The name ${nameTextController.text} has been used, please try another name.'),
                                //         actions: <Widget>[
                                //           TextButton(
                                //               onPressed: () {
                                //                 nameTextController.clear();
                                //               },
                                //               child: const Text('OK'))
                                //         ],
                                //       );
                                //     } else {
                                //       if (otherCategory == true) {
                                //         firebaseFirestore
                                //             .collection('products')
                                //             .doc(pid)
                                //             .set({
                                //           'pid': pid,
                                //           'productName':
                                //               nameTextController.text,
                                //           'price': priceTextController.hashCode,
                                //           'category': productDDValue,
                                //           'company': companyTextController.text,
                                //           otherTextController.text:
                                //               otherDetailController.text,
                                //           'modifyName': '${data['firstName']}',
                                //           'modifyDate': dateNtime,
                                //         });
                                //       } else {
                                //         firebaseFirestore
                                //             .collection('products')
                                //             .doc(pid)
                                //             .set({
                                //           'pid': pid,
                                //           'productName':
                                //               nameTextController.text,
                                //           'price': priceTextController.text,
                                //           'category': productDDValue,
                                //           'company': companyTextController.text,
                                //           'modifyName': '${data['firstName']}',
                                //           'modifyDate': dateNtime,
                                //         });
                                //       }
                                //       return AlertDialog(
                                //         title: const Text('New Product Added!'),
                                //         content: Text(
                                //             '${nameTextController.text} has been succesfully added.'),
                                //         actions: <Widget>[
                                //           TextButton(
                                //               onPressed: () {
                                //                 clearTextController();
                                //               },
                                //               child: const Text('OK'))
                                //         ],
                                //       );
                                //     }
                                //   },
                                // );

                                // tmpPid.get().then((snapshot) {
                                //   if (snapshot.exists) {
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(
                                //             content: Text(
                                //                 'The following name ${nameTextController.text} had been used. Please try another name')));
                                //     nameTextController.clear();
                                //   } else {
                                //     if (otherCategory == true) {
                                //       firebaseFirestore
                                //           .collection('products')
                                //           .doc(pid)
                                //           .set({
                                //         'pid': pid,
                                //         'productName': nameTextController.text,
                                //         'price': priceTextController.hashCode,
                                //         'category': productDDValue,
                                //         'company': companyTextController.text,
                                //         otherTextController.text:
                                //             otherDetailController.text,
                                //         'modifyName': '${data['firstName']}',
                                //         'modifyDate': dateNtime,
                                //       });
                                //     } else {
                                //       firebaseFirestore
                                //           .collection('products')
                                //           .doc(pid)
                                //           .set({
                                //         'pid': pid,
                                //         'productName': nameTextController.text,
                                //         'price': priceTextController.text,
                                //         'category': productDDValue,
                                //         'company': companyTextController.text,
                                //         'modifyName': '${data['firstName']}',
                                //         'modifyDate': dateNtime,
                                //       });
                                //     }
                                //   }
                                // });
                              }
                            },
                            icon: const Icon(Icons.new_label),
                            label: const Text('SAVE PRODUCT')),
                      ],
                    ),
                  ),
                ),
              ),
            )),
          );
        }
        return Container();
      },
    );
  }
}
