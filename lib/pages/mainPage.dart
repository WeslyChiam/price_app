import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:price_app/pages/addProductPage.dart';
import 'package:price_app/pages/loginPage.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final List<String> product = <String>[];
  final _advancedDrawerController = AdvancedDrawerController();
  final user = FirebaseAuth.instance.currentUser!;
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  // final Stream<QuerySnapshot> usersStream =
  //     FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Signed in as ${user.email!}'),
      duration: const Duration(milliseconds: 1500),
    ));

    // final firstName = FirebaseFirestore.instance
    //     .collection('users')
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {});
    return StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Oops!'),
              content:
                  const Text('Something went wrong, please try login again.'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const loginPage()));
                    },
                    child: const Text('OK')),
              ],
            );
          }
          return AdvancedDrawer(
              backdropColor: deepBlue,
              controller: _advancedDrawerController,
              animationCurve: Curves.bounceInOut,
              animationDuration: const Duration(milliseconds: 300),
              animateChildDecoration: true,
              rtlOpening: false,
              disabledGestures: true,
              childDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Recent Changes'),
                  leading: IconButton(
                    onPressed: _handleMenuButtonPressed,
                    icon: ValueListenableBuilder<AdvancedDrawerValue>(
                      valueListenable: _advancedDrawerController,
                      builder: (_, value, __) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Icon(
                            value.visible ? Icons.clear : Icons.menu,
                            key: ValueKey<bool>(value.visible),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                body: Center(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultText(
                            'Recent Update', 20.0, false, true, true),
                      ),
                      Container(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(20.0),
                              child: Table(
                                defaultColumnWidth:
                                    const FixedColumnWidth(100.0),
                                border: TableBorder.all(
                                  color: black,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                children: [
                                  TableRow(children: [
                                    Column(
                                      children: [
                                        defaultText(
                                            'Code', 15.0, false, false, true)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        defaultText(
                                            'Name', 15.0, false, false, true)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        defaultText('Category', 15.0, false,
                                            false, true)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        defaultText(
                                            'Price', 15.0, false, false, true)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        defaultText(
                                            'Company', 15.0, false, false, true)
                                      ],
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            Container(
                              height: 50.0,
                              width: 250.0,
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              addProductPage()),
                                    );
                                  },
                                  child: defaultText(
                                      'Add Product', 25.0, false, false, true)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              drawer: SafeArea(
                  child: ListTileTheme(
                textColor: white,
                iconColor: white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 128.0,
                      height: 128.0,
                      margin: const EdgeInsets.only(
                        top: 24.0,
                        bottom: 64.0,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: lightBlack,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.account_circle,
                              size: 120.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text('WELCONE'),

                    // ListView(
                    //   children:
                    //       snapshot.data!.docs.map((DocumentSnapshot document) {
                    //     Map<String, dynamic> data =
                    //         document.data()! as Map<String, dynamic>;
                    //     return ListTile(
                    //         title: Text('Hi, ${data['firstName']}'));
                    //   }).toList(),
                    // ),

                    // defaultText(user.email!, 20.0, false, true, false),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('View Data'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.price_change),
                      title: const Text('Update Product'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => addProductPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Setting'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text('Help'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const loginPage(),
                            ),
                            (route) => false);
                      },
                    ),

                    const Spacer(),
                    DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: lightWhite,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          child: Column(
                            children: [
                              const Text('Terms of Service | Privacy Policy'),
                              GestureDetector(
                                onTap: () {},
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )));
        });
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
