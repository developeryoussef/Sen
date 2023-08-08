// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, unused_field, use_key_in_widget_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mrs_geology_admin/view/screens/addquiz.dart';
import 'package:mrs_geology_admin/view/screens/homepage.dart';
import 'package:mrs_geology_admin/view/screens/onboardingpage.dart';
import 'package:mrs_geology_admin/view/screens/profilepage.dart';
import 'package:mrs_geology_admin/view/screens/students/mainstudents.dart';
import '../main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'view/screens/searchpage.dart';

class ViewController extends StatefulWidget {
  @override
  _ViewControllerState createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {
  auth() async {
    return await FirebaseAuth.instance.currentUser?.uid == null
        ? FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: 'seniorasara@gmail.com', password: 'senioraQuizes1102')
        : null;
  }

  @override
  void initState() {
    auth();
    sharedPreferences!.getString('term') != 'First term' ||
            sharedPreferences!.getString('term') != 'Second term'
        ? sharedPreferences!.setString('term', 'First term')
        : null;

    super.initState();
  }

  int currentindex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AddQuizPage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: currentindex != 2
          ? AppBar(
              iconTheme: currentindex == 2 ? null : IconThemeData.fallback(),
              actions: currentindex != 2
                  ? null
                  : [
                      IconButton(onPressed: () {}, icon: Icon(LineIcons.search))
                    ],
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'Seniora Sara Quizes',
                style: TextStyle(color: Colors.black),
              ),
            )
          : null,
      backgroundColor: itGrey,
      body: _widgetOptions[currentindex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: itGrey,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey.shade300,
              hoverColor: Colors.grey[300]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 600),
              tabBackgroundColor: itGreen,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.ad,
                  text: 'Add Quiz',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: currentindex,
              onTabChange: (index) {
                setState(() {
                  currentindex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
