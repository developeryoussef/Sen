// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sort_child_properties_last, sized_box_for_whitespace, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrs_geology_admin/controller/navigationcontroller.dart';
import 'package:mrs_geology_admin/main.dart';
import 'package:mrs_geology_admin/view/screens/students/studentpage.dart';
import 'package:line_icons/line_icons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(LineIcons.search))],
        elevation: 0,
        backgroundColor: itGreen,
        centerTitle: true,
        title: Text(
          'Italiano',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search student',
                      ),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5),
                      ],
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.grey.shade300,
                    ),
                    height: 65,
                    width: Get.width - 50,
                  ),
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: itGreen,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3), blurRadius: 20),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(85),
                    bottomRight: Radius.circular(85),
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 11,
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('students')
                    .orderBy('studentrank', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Text(
                      'There isn\'t any student yet',
                      style: TextStyle(fontSize: 20, color: itRed),
                    ));
                  }
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            if (name.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                  child: ListTile(
                                      onTap: () {
                                        Get.to(
                                          StudentPage(
                                            mdid: snapshot.data!.docs[index].id,
                                            email: data['email'],
                                            name: data['name'],
                                            imageurl: data['imageurl'],
                                          ),
                                        );
                                      },
                                      trailing: Text(
                                        data['studentrank'].toString(),
                                        style: TextStyle(
                                            fontSize: 12, color: itRed),
                                      ),
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            NetworkImage(data['imageurl']),
                                      ),
                                      subtitle: Text(data['email']),
                                      title: Text(data['name'])),
                                ),
                              );
                            } else if (data['name']
                                .toString()
                                .startsWith(name.toLowerCase())) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                  child: ListTile(
                                      onTap: () {
                                        Get.to(
                                          StudentPage(
                                            mdid: snapshot.data!.docs[index].id,
                                            email: data['email'],
                                            name: data['name'],
                                            imageurl: data['imageurl'],
                                          ),
                                        );
                                      },
                                      trailing: Text(
                                        data['studentrank'].toString(),
                                        style: TextStyle(
                                            fontSize: 12, color: itRed),
                                      ),
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            NetworkImage(data['imageurl']),
                                      ),
                                      subtitle: Text(data['email']),
                                      title: Text(data['name'])),
                                ),
                              );
                            }
                            return Center();
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
