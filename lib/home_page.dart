import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_model/add_list.dart';
import 'package:flutter/material.dart';

import 'edit_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseFirestore.instance.collection('names');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Names'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddList()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('No list found'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditList(
                                docEdit: snapshot.data!.docs[index],
                              )));
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          snapshot.data!.docs[index]['names'],
                        ))),
                  );
                },
              );
            }
          }),
    );
  }
}
