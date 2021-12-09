import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditList extends StatefulWidget {
  DocumentSnapshot docEdit;
  EditList({Key? key, required this.docEdit}) : super(key: key);

  @override
  _EditListState createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  TextEditingController names = TextEditingController();
  @override
  void initState() {
    names = TextEditingController(text: widget.docEdit['names']);
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Name'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () {
                widget.docEdit.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.docEdit.reference.update({
            'names': names.text,
          }).whenComplete(() => Navigator.pop(context));
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          autocorrect: true,
          controller: names,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: "Edit Name",
            hintStyle: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
