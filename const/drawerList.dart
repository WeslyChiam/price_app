import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_app/pages/authPage.dart';
import 'package:price_app/pages/helpPage.dart';
import 'package:price_app/pages/loginPage.dart';
import 'package:price_app/pages/settingPage.dart';
import 'package:price_app/pages/recordPage.dart';

class drawerList extends StatelessWidget {
  final String name;
  drawerList(this.name);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(name == 'history'
          ? Icons.receipt
          : name == 'update'
              ? Icons.dashboard_customize
              : name == 'setting'
                  ? Icons.settings
                  : name == 'auth'
                      ? Icons.star
                      : name == 'help'
                          ? Icons.help
                          : name == 'logout'
                              ? Icons.logout
                              : Icons.abc),
      title: name == 'history'
          ? const Text('View Record')
          : name == 'update'
              ? const Text('Update Product')
              : name == 'setting'
                  ? const Text('Setting')
                  : name == 'auth'
                      ? const Text('Authority')
                      : name == 'help'
                          ? const Text('Help')
                          : name == 'logout'
                              ? const Text('Logout')
                              : const Text(''),
      onTap: name == 'history'
          ? () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => historyPage()));
            }
          : name == 'update'
              ? () {}
              : name == 'setting'
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => settingPage()));
                    }
                  : name == 'auth'
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => authPage()));
                        }
                      : name == 'help'
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const helpPage()));
                            }
                          : name == 'logout'
                              ? () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const loginPage()),
                                      (route) => false);
                                }
                              : () {},
    );
  }
}
