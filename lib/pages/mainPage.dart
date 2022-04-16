import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/drawerList.dart';
import 'package:price_app/model/table_model.dart';
import 'package:price_app/pages/loginPage.dart';
import 'package:price_app/pages/tncPage.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final List<String> product = <String>[];
  final _advancedDrawerController = AdvancedDrawerController();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something Went Wrong, Please Try Again'),
              duration: Duration(seconds: 3),
            ));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const loginPage()));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Welcome, ${data['firstName']}')));
            return StreamBuilder<QuerySnapshot>(
              stream: _userStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    body: ListView(
                      padding: const EdgeInsets.all(8.0),
                      children: [Text('Recent Changes'), recentTable()],
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
                                  )
                                ],
                              ),
                            ),
                          ),
                          Text('Hi, ${data['firstName']}'),
                          drawerList('view'),
                          drawerList('add'),
                          drawerList('setting'),
                          drawerList('auth'),
                          drawerList('help'),
                          drawerList('logout'),
                          const Spacer(),
                          DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 12.0, color: lightWhite),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Column(
                                  children: [
                                    const Text(
                                        'Terms of Service | Privacy Policy'),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    tncPage()));
                                      },
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        });
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
