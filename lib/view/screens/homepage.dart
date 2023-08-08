// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mrs_geology_admin/main.dart';
import 'package:mrs_geology_admin/view/screens/onboardingpage.dart';
import 'package:mrs_geology_admin/view/screens/students/mainstudents.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QuizesView(
              color: itRed,
              primary: 'Prep 1',
            ),
            QuizesView(
              color: itGreen,
              primary: 'Prep 2',
            ),
            QuizesView(
              color: itRed,
              primary: 'Prep 3',
            ),
            QuizesView(
              color: itGreen,
              primary: 'Senior 1',
            ),
            QuizesView(
              color: itRed,
              primary: 'Senior 2',
            ),
            QuizesView(
              color: itGreen,
              primary: 'Senior 3',
            ),
          ],
        ),
      ),
    );
  }
}

class QuizesView extends StatelessWidget {
  final Color? color;
  final String? primary;
  const QuizesView({
    super.key,
    required this.color,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                primary!,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
                flex: 4,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('quizes')
                      .doc('firsterm')
                      .collection('quizes')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: itRed,
                        ),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        var did = snapshot.data!.docs[index].id;
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    LineIcons.question,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data['name'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            width: Get.width / 4.5,
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: color),
                          ),
                        );
                      },
                    );
                  },
                )),
          ],
        ),
        width: Get.width - 30,
        height: Get.height / 5,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
