import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddList extends StatelessWidget {
  TextEditingController names = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('names');
  AddList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Names'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          autocorrect: true,
          controller: names,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: "Add Name",
            hintStyle: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.add({'names': names.text}).whenComplete(
              () => Navigator.pop(context));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
