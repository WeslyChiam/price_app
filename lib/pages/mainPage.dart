import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/text.dart';
import 'package:price_app/const/userInput.dart';
import 'package:price_app/pages/addProductPage.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final List<String> product = <String>[];
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: deepBlue,
      controller: _advancedDrawerController,
      animationCurve: Curves.bounceInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: true,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(
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
                  duration: Duration(milliseconds: 250),
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
                padding: EdgeInsets.all(10.0),
                child: defaultText('Recent Update', 20.0, false, true, true),
              ),
              Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(100.0),
                        border: TableBorder.all(
                          color: black,
                          style: BorderStyle.solid,
                          width: 2.0,
                        ),
                        children: [
                          TableRow(children: [
                            Column(
                              children: [
                                defaultText('Code', 15.0, false, false, true)
                              ],
                            ),
                            Column(
                              children: [
                                defaultText('Name', 15.0, false, false, true)
                              ],
                            ),
                            Column(
                              children: [
                                defaultText(
                                    'Category', 15.0, false, false, true)
                              ],
                            ),
                            Column(
                              children: [
                                defaultText('Price', 15.0, false, false, true)
                              ],
                            ),
                            Column(
                              children: [
                                defaultText('Company', 15.0, false, false, true)
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
                                  builder: (context) => addProductPage()),
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
          child: Container(
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
                child: const Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 120.0,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addProductPage()),
                  );
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
        ),
      )),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
