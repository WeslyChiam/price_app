import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:price_app/const/color.dart';

class updateTextFormFieldInput extends StatefulWidget {
  String pid;
  updateTextFormFieldInput(this.pid);

  @override
  State<updateTextFormFieldInput> createState() =>
      _updateTextFormFieldInputState();
}

class _updateTextFormFieldInputState extends State<updateTextFormFieldInput> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final formKey = GlobalKey<FormState>();
  final priceNumController = TextEditingController();
  final distributorTextController = TextEditingController();
  final materialTextController = TextEditingController();
  final otherTextController = TextEditingController();
  final otherDetailTextController = TextEditingController();
  Map<String, bool> values = {
    'updatePrice': false,
    'updateCompany': false,
    'updateMaterial': false,
    'updateOther': false,
    'updateDetail': false,
  };
  bool updatePrice = false;
  bool updateCompany = false;
  bool updateMaterial = false;
  bool updateOther = false;
  bool updateDetail = false;
  bool auth = false;

  RegExp regex = RegExp(r'^[a-zA-Z0-9 ]([\w -]*[a-zA-Z0-9]){3,50}?$');
  RegExp intregex = RegExp(r'^(?:-?(?:0|[1-9,.][0-9,.]*))$');

  @override
  void dispose() {
    priceNumController.dispose();
    distributorTextController.dispose();
    materialTextController.dispose();
    otherTextController.dispose();
    otherDetailTextController.dispose();
    super.dispose();
  }

  void clearTextController() {
    priceNumController.clear();
    distributorTextController.clear();
    materialTextController.clear();
    otherTextController.clear();
    otherDetailTextController.clear();
  }

  Widget checkBtn(key) {
    return Checkbox(
        value: values[key],
        checkColor: white,
        onChanged: (bool? value) {
          setState(() {
            values[key] = value!;
          });
        });
  }

  Widget inputForm(dataType, enable) {
    return TextFormField(
        autofocus: false,
        enabled: enable,
        controller: dataType == 'price'
            ? priceNumController
            : dataType == 'distributor'
                ? distributorTextController
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
                      return ('Cannot be empty');
                    } else if (!intregex.hasMatch(value)) {
                      return ('Only accept number');
                    }
                  }
                : (value) {
                    if (value!.isEmpty) {
                      return ('Cannot be empty');
                    } else if (!regex.hasMatch(value)) {
                      return ('Must be between 3 to 50 letters');
                    }
                  }
            : null,
        onSaved: dataType == 'price'
            ? (value) => priceNumController.text = value!
            : dataType == 'distributor'
                ? (value) => distributorTextController.text = value!
                : dataType == 'material'
                    ? (value) => materialTextController.text = value!
                    : dataType == 'other'
                        ? (value) => otherTextController.text = value!
                        : (value) => otherDetailTextController.text = value!,
        decoration: InputDecoration(
          prefixIcon: Icon(
            dataType == 'price'
                ? Icons.price_change
                : dataType == 'distributor'
                    ? Icons.add_business
                    : dataType == 'material'
                        ? Icons.hive
                        : dataType == 'other'
                            ? Icons.add_box
                            : Icons.add_card,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: dataType == 'price'
              ? 'Price (RM)'
              : dataType == 'distributor'
                  ? 'Distributor'
                  : dataType == 'material'
                      ? 'Material Name'
                      : dataType == 'other'
                          ? 'Other Attribute Name'
                          : 'Details',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));
  }

  Widget priceFormInput() {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: updatePrice,
        title: inputForm('price', updatePrice),
        onChanged: (bool? value) {
          setState(() {
            updatePrice = value!;
          });
        });
  }

  Widget distributorFormInput() {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: updateCompany,
        title: inputForm('distributor', updateCompany),
        onChanged: (bool? value) {
          setState(() {
            updateCompany = value!;
          });
        });
  }

  Widget materialFormInput() {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: updateMaterial,
        title: inputForm('material', updateMaterial),
        onChanged: (bool? value) {
          setState(() {
            updateMaterial = value!;
          });
        });
  }

  Widget otherAtrFormInput() {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: updateOther,
        title: inputForm('other', updateOther),
        onChanged: (bool? value) {
          setState(() {
            updateOther = value!;
          });
        });
  }

  Widget otherAtrDetailFormInput() {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: updateDetail,
        title: inputForm('', updateDetail),
        onChanged: (bool? value) {
          setState(() {
            updateDetail = value!;
            // if (updateDetail = false) {
            //   otherDetailTextController.clear();
            // }
          });
        });
  }

  _fetchAuth() async {
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      setState(() {
        auth = value.data()!['authority'];
      });
    });
  }

  Future addTrack(String pid, String price, String distributor, String material,
      String date, String uid, bool approve) async {
    String id = 'UPDATE' + pid + date;
    DocumentReference track =
        FirebaseFirestore.instance.collection('tracks').doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      track.set({
        'id': id,
        'pid': pid,
        'price': price,
        'action': 'UPDATE',
        'distributor': distributor,
        'material': material,
        'writtenDate': date,
        'wroteBy': uid,
        'approve': approve,
      });
    });
  }

  Future updateProduct(String pid, String price, String distributor,
      String material, String date, String uid) async {
    CollectionReference product =
        FirebaseFirestore.instance.collection('products');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        if (updatePrice == true) {
          product.doc(pid).update({'price': price});
        }
        if (updateCompany == true) {
          product.doc(pid).update({'distributor': distributor});
        }
        if (updateMaterial == true) {
          product.doc(pid).update({'material': material});
        }
      });
      product.doc(pid).update({
        'writtenDate': date,
        'wroteBy': uid,
      }).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Succesfully Updated')));
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to Update: ${e.toString()}')));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final pid = widget.pid;
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 35.0),
          priceFormInput(),
          const SizedBox(height: 20.0),
          distributorFormInput(),
          const SizedBox(height: 20.0),
          materialFormInput(),
          const SizedBox(height: 20.0),
          otherAtrFormInput(),
          const SizedBox(height: 20.0),
          otherAtrDetailFormInput(),
          const SizedBox(height: 20.0),
          Container(
            height: 50.0,
            width: 250.0,
            decoration: BoxDecoration(
                color: blue, borderRadius: BorderRadius.circular(20)),
            child: TextButton.icon(
              icon: const Icon(Icons.save, color: white),
              label: const Text('UPDATE', style: TextStyle(color: white)),
              onPressed: () async {
                DateTime now = DateTime.now();
                String date = now.day.toString() +
                    '/' +
                    now.month.toString() +
                    '/' +
                    now.year.toString();
                if (_fetchAuth() == true) {
                  await addTrack(
                      pid,
                      priceNumController.text,
                      distributorTextController.text,
                      materialTextController.text,
                      date,
                      uid,
                      true);
                  await updateProduct(
                      pid,
                      priceNumController.text,
                      distributorTextController.text,
                      materialTextController.text,
                      date,
                      uid);
                } else {
                  await addTrack(
                      pid,
                      priceNumController.text,
                      distributorTextController.text,
                      materialTextController.text,
                      date,
                      uid,
                      true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Your request is now pending')));
                }
              },
            ),
          ),
          const SizedBox(height: 35.0),
        ],
      ),
    );
  }
}
