import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:price_app/const/bottomTable.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/deleteTrack.dart';
import 'package:price_app/const/drawerList.dart';
import 'package:price_app/const/getFirstName.dart';
import 'package:price_app/pages/addProductPage.dart';
import 'package:price_app/pages/deleteAlert.dart';
import 'package:price_app/pages/tncPage.dart';
import 'package:price_app/pages/updatePage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  ScrollController productListScrollController = ScrollController();
  ScrollController materialListScrollController = ScrollController();
  TextEditingController keywordController = TextEditingController();
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: getFirstName("Welcome, ", uid, "")));
    String photoURL = FirebaseAuth.instance.currentUser!.photoURL.toString();

    return StreamBuilder<QuerySnapshot>(
      stream: _userStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Container(
                  width: double.infinity,
                  height: 40,
                  color: white,
                  child: TextField(
                    controller: keywordController,
                    onChanged: (value) {
                      setState(() {
                        keyword = value.toString();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
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
              body: productList(productListScrollController, keyword, uid),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => addProductPage()));
                },
                backgroundColor: blue,
                child: const Icon(Icons.add),
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
                    child: const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage("https://picsum.photos/300/300"),
                        ),
                      ),
                    ),
                  ),
                  getFirstName("Hi, ", uid, ""),
                  drawerList('history'),
                  drawerList('setting'),
                  drawerList('auth'),
                  drawerList('help'),
                  drawerList('logout'),
                  const Spacer(),
                  DefaultTextStyle(
                      style: const TextStyle(fontSize: 12.0, color: lightWhite),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            const Text('Terms of Service | Privacy Policy'),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const tncPage()));
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

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}

class productList extends StatelessWidget {
  final ScrollController controller;
  final keyword;
  final uid;
  productList(this.controller, this.keyword, this.uid);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: keyword != "" && keyword != null
            ? FirebaseFirestore.instance
                .collection("products")
                .where("productName", isEqualTo: keyword)
                .snapshots()
            : FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong, please try again."),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Row(
                  children: const <Widget>[
                    Text("Loading..."),
                    SpinKitFadingCircle(color: grey),
                  ],
                ),
              );

            default:
              final data = snapshot.requireData;
              const String airSVG = 'assets/svg/air.svg';
              const String otherSVG = 'assets/svg/other.svg';
              const String pipeSVG = 'assets/svg/pipe.svg';
              const String mechSVG = 'assets/svg/mech.svg';
              const String elecSVG = 'assets/svg/elec.svg';
              if (data.size == 0) {
                return const Center(
                  child: Text(
                      "No data has found. Try add a new one by pressing '+' button"),
                );
              }
              return DraggableScrollbar.semicircle(
                controller: controller,
                child: ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          splashColor: grey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: SvgPicture.asset(
                                    data.docs[index]["category"] == "AIR"
                                        ? airSVG
                                        : data.docs[index]["category"] == "PIPE"
                                            ? pipeSVG
                                            : data.docs[index]["category"] ==
                                                    "ELEC"
                                                ? elecSVG
                                                : data.docs[index]
                                                            ["category"] ==
                                                        "MECH"
                                                    ? mechSVG
                                                    : otherSVG,
                                    width: 20,
                                    height: 20),
                                title: Text(data.docs[index]["productName"]),
                                subtitle: Text(
                                    "Last updated: ${data.docs[index]['writtenDate']}"),
                                trailing:
                                    Text("RM ${data.docs[index]['price']}"),
                              )
                            ],
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200,
                                    color: white,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          bottomMainTable(
                                              data.docs[index]['productName'],
                                              data.docs[index]['price'],
                                              data.docs[index]['distributor'],
                                              data.docs[index]['material'],
                                              data.docs[index]['category'],
                                              true,
                                              data.docs[index]['wroteBy'],
                                              data.docs[index]['writtenDate']),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                height: 50,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: TextButton.icon(
                                                  icon: const Icon(Icons.update,
                                                      color: white),
                                                  label: const Text(
                                                    "Update",
                                                    style:
                                                        TextStyle(color: white),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                updatePage(
                                                                    data.docs[
                                                                            index]
                                                                        ['pid'],
                                                                    uid)));
                                                  },
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: clear,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: TextButton.icon(
                                                  icon: const Icon(Icons.close,
                                                      color: black),
                                                  label: const Text("Close",
                                                      style: TextStyle(
                                                          color: black)),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: TextButton.icon(
                                                  icon: const Icon(Icons.delete,
                                                      color: white),
                                                  label: const Text(
                                                    "Remove",
                                                    style:
                                                        TextStyle(color: white),
                                                  ),
                                                  onPressed: () async {
                                                    var tmpName =
                                                        data.docs[index]
                                                            ['productName'];
                                                    var tmpPID =
                                                        data.docs[index]['pid'];
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                deleteAlert(
                                                                    tmpPID,
                                                                    tmpName)));
                                                    // CollectionReference users =
                                                    //     FirebaseFirestore
                                                    //         .instance
                                                    //         .collection(
                                                    //             "users");
                                                    // FutureBuilder(
                                                    //   future:
                                                    //       users.doc(uid).get(),
                                                    //   builder: (BuildContext
                                                    //           context,
                                                    //       AsyncSnapshot<
                                                    //               DocumentSnapshot>
                                                    //           snapshot) {
                                                    //     if (snapshot
                                                    //             .connectionState ==
                                                    //         ConnectionState
                                                    //             .done) {
                                                    //       Map<String, dynamic>
                                                    //           data = snapshot
                                                    //                   .data!
                                                    //                   .data()
                                                    //               as Map<String,
                                                    //                   dynamic>;
                                                    //       bool auth =
                                                    //           data['authority'];
                                                    //       return AlertDialog(
                                                    //         title: Text(
                                                    //             "Delete $tmpName?"),
                                                    //         content: Text(
                                                    //             "This action will remove $tmpName from Database. Doing so will unable to undo. /nAre you sure?"),
                                                    //         actions: <Widget>[
                                                    //           TextButton.icon(
                                                    //             icon: const Icon(
                                                    //                 Icons
                                                    //                     .check_outlined),
                                                    //             label:
                                                    //                 const Text(
                                                    //                     'YES'),
                                                    //             onPressed: () {
                                                    //               DateTime now =
                                                    //                   DateTime
                                                    //                       .now();
                                                    //               String date = now
                                                    //                       .day
                                                    //                       .toString() +
                                                    //                   '/' +
                                                    //                   now.month
                                                    //                       .toString() +
                                                    //                   '/' +
                                                    //                   now.year
                                                    //                       .toString();
                                                    //               String id =
                                                    //                   'DELETE' +
                                                    //                       tmpPID +
                                                    //                       date;
                                                    //               if (auth ==
                                                    //                   true) {
                                                    //                 removeTrack(
                                                    //                         id)
                                                    //                     .Pending(
                                                    //                         tmpPID,
                                                    //                         date,
                                                    //                         uid,
                                                    //                         auth);
                                                    //                 removeTrack(
                                                    //                         id)
                                                    //                     .Product();
                                                    //                 ScaffoldMessenger.of(
                                                    //                         context)
                                                    //                     .showSnackBar(const SnackBar(
                                                    //                         content:
                                                    //                             Text('Succesfully remove product')));
                                                    //               } else {
                                                    //                 removeTrack(
                                                    //                         id)
                                                    //                     .Pending(
                                                    //                         tmpPID,
                                                    //                         date,
                                                    //                         uid,
                                                    //                         auth);
                                                    //                 ScaffoldMessenger.of(
                                                    //                         context)
                                                    //                     .showSnackBar(const SnackBar(
                                                    //                         content:
                                                    //                             Text('Your request is now pending')));
                                                    //               }
                                                    //               Navigator.pop(
                                                    //                   context);
                                                    //             },
                                                    //           ),
                                                    //         ],
                                                    //       );
                                                    //     }
                                                    //     return Container();
                                                    //   },
                                                    // );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      );
                    }),
              );
          }
        });
  }
}
