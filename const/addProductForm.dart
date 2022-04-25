import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:price_app/const/color.dart';
// import 'package:price_app/const/addData.dart';

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
  bool auth = false;

  // RegExp regex = RegExp(r'^[a-zA-Z0-9_ ]{3,50}$');
  RegExp regex = RegExp(r'^[a-zA-Z0-9 ]([\w -]*[a-zA-Z0-9]){2,50}?$');
  RegExp intregex = RegExp(r'^(?:-?(?:0|[1-9.,][0-9.,]*))$');

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

  Widget addOtherBtn() {
    return TextButton.icon(
        onPressed: () {
          setState(() {
            otherCategory != otherCategory;
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('Add other attribute'));
  }

  Widget otherTextFormInput() {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: otherCategory,
        title: TextFormField(
          autofocus: false,
          enabled: otherCategory,
          controller: otherTextController,
          keyboardType: TextInputType.name,
          validator: otherCategory == true
              ? (value) {
                  if (value!.isEmpty) {
                    return ('Cannot be empty');
                  } else if (!regex.hasMatch(value)) {
                    return ('Must be between 3 to 50 letters');
                  }
                }
              : null,
          onSaved: (value) => otherTextController.text = value!,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.add_box),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Other Attribute Name',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        onChanged: (bool? value) {
          setState(() {
            otherCategory = value!;
          });
        });
  }

  Widget otherDetailTextFormInput(bool otherCategory) {
    return TextFormField(
      autofocus: false,
      enabled: otherCategory,
      controller: otherDetailTextController,
      keyboardType: TextInputType.name,
      validator: otherCategory == true
          ? (value) {
              if (value!.isEmpty) {
                return ('Cannot be empty');
              } else if (!regex.hasMatch(value)) {
                return ('Must be between 3 to 50 letters');
              }
            }
          : null,
      onSaved: (value) => otherDetailTextController.text = value!,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.add_card),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Details',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
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
      validator: enable == true
          ? dataType == 'price'
              ? (value) {
                  if (value!.isEmpty) {
                    return ('Price cannot be empty');
                  } else if (!intregex.hasMatch(value)) {
                    return ('Only accept number');
                  }
                }
              : (value) {
                  if (value!.isEmpty) {
                    return ('Name cannot be empty');
                  } else if (!regex.hasMatch(value)) {
                    return ('Name must be between 3 to 50 letters');
                  }
                  return null;
                }
          : null,
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

  Future addTrack(String pid, String name, String price, String distributor,
      String material, String category, String date, bool approve) async {
    DateTime now = DateTime.now();
    String time =
        now.day.toString() + now.month.toString() + now.year.toString();
    String id = 'ADD' + name + time;
    DocumentReference track =
        FirebaseFirestore.instance.collection('tracks').doc(id);
    String uid = FirebaseAuth.instance.currentUser!.uid;

    checkCounter();
    CollectionReference track_ref =
        FirebaseFirestore.instance.collection('tracks');
    if (otherCategory == true) {
      track.set({
        'pid': pid,
        'id': id,
        'productName': name,
        'price': price,
        'distributor': distributor,
        'material': material,
        'category': productDDValue,
        'wroteBy': uid,
        'action': 'ADD',
        'writtenDate': date,
        'approve': approve,
      });
      FirebaseFirestore.instance
          .collection('tracks')
          .doc('$id/otherAtr/${otherTextController.text}')
          .set({
        'atrName': otherTextController.text,
        'atrDetail': otherDetailTextController.text,
      });
    } else {
      track.set({
        'pid': pid,
        'id': id,
        'productName': name,
        'price': price,
        'distributor': distributor,
        'material': material,
        'category': productDDValue,
        'wroteBy': uid,
        'action': 'ADD',
        'writtenDate': date,
        'approve': approve,
      });
    }
  }

  Future addProduct(String pid, String name, String price, String distributor,
      String material, String category, String date) async {
    DocumentReference product_ref =
        FirebaseFirestore.instance.collection('products').doc(pid);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(product_ref);
        if (!snapshot.exists) {
          if (otherCategory == false) {
            product_ref.set({
              'pid': pid,
              'productName': name,
              'price': price,
              'distributor': distributor,
              'material': material,
              'category': productDDValue,
              'wroteBy': uid,
              'writtenDate': date,
            }).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added!')));
            }).catchError((error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString())));
            });
          } else {
            product_ref.set({
              'pid': pid,
              'productName': name,
              'price': price,
              'distributor': distributor,
              'material': material,
              'category': productDDValue,
              'wroteBy': uid,
              'writtenDate': date,
              'otherAtr': {
                otherTextController.text: {
                  'AtrName': otherTextController.text,
                  'AtrDetail': otherDetailTextController.text,
                },
              },
            }).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added!')));
            }).catchError((error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString())));
            });
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$name has already been used')));
        clearTextController();
        return Container();
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Something went wrong. Please try again.")));
            Navigator.pop(context);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            bool auth = data['authority'];
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
                    otherTextFormInput(),
                    const SizedBox(height: 20.0),
                    otherDetailTextFormInput(otherCategory),
                    const SizedBox(height: 20.0),
                    Container(
                      height: 50.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextButton.icon(
                          onPressed: () async {
                            DateTime now = DateTime.now();
                            String date = now.day.toString() +
                                '/' +
                                now.month.toString() +
                                '/' +
                                now.year.toString();

                            String pid =
                                productDDValue + nameTextController.text;
                            if (formKey.currentState!.validate()) {
                              final auth = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid);

                              //
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(content: Text(auth.toString())));
                              if (data['authority'] == true) {
                                await addTrack(
                                    pid,
                                    nameTextController.text,
                                    priceNumController.text,
                                    companyTextController.text,
                                    materialTextController.text,
                                    productDDValue,
                                    date,
                                    true);
                                await addProduct(
                                  pid,
                                  nameTextController.text,
                                  priceNumController.text,
                                  companyTextController.text,
                                  materialTextController.text,
                                  productDDValue,
                                  date,
                                );
                              } else {
                                await addTrack(
                                    pid,
                                    nameTextController.text,
                                    priceNumController.text,
                                    companyTextController.text,
                                    materialTextController.text,
                                    productDDValue,
                                    date,
                                    false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Your request is now pending')));
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.save_outlined,
                            color: white,
                          ),
                          label: const Text(
                            'SAVE',
                            style: TextStyle(color: white),
                          )),
                    ),
                  ],
                ));
          }
          return Container();
        });
  }
}

checkCounter() {
  CollectionReference track = FirebaseFirestore.instance.collection('tracks');
  return FutureBuilder(
      future: track.doc('otherAtr').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        return Container();
      });
}
