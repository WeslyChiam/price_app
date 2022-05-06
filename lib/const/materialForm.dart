import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class materialFormInput extends StatelessWidget {
  final String name;
  materialFormInput(this.name);
  RegExp intregex = RegExp(r'^(?:-?(?:0|[1-9. ][0-9. ]*))$');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            controller: priceController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please enter a new price");
              }
              if (!intregex.hasMatch(value)) {
                return ("Only accept number");
              }
            },
            onSaved: (value) {
              priceController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.price_change),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Latest Price",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          TextButton.icon(
            icon: const Icon(Icons.update),
            label: const Text("Update"),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  void updatePrice() {
    if (_formKey.currentState!.validate()) {
      CollectionReference material =
          FirebaseFirestore.instance.collection('material');
      var tmpPrice = '';
      material.get().then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((data) {
          if (data["materialName"] == name) {
            tmpPrice = data['currentPrice'];
          }
        });
      });

      var last_price = double.parse(tmpPrice);
      var cr_price = double.parse(priceController.text);
      var diff = (100 - (cr_price / last_price) * 100).toString();
      bool rise = (cr_price > last_price);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        material.doc(name).update({
          'lastPrice': tmpPrice,
          'currentPrice': priceController.text,
        });
      });
    }
  }
}
