// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, avoid_print, body_might_complete_normally_nullable, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrs_geology_admin/controller/navigationcontroller.dart';
import 'package:mrs_geology_admin/main.dart';
import 'package:mrs_geology_admin/view/screens/students/studentpage.dart';

class AddQuizPage extends StatelessWidget {
  const AddQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: itGrey,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new quiz',
        backgroundColor: itGreen,
        child: Icon(
          Icons.add_home_work_rounded,
        ),
        onPressed: () {},
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/Picture1.png'),
            Text(
              'Tap the add button to create new quiz',
              style: TextStyle(fontSize: 16.5),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
