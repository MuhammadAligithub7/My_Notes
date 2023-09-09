import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:note_app/Screens/HomeScreen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  TextEditingController editNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Note'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal:5),
              child: TextFormField(
                maxLines: null,
                controller: editNoteController..text = Get.arguments['note'].toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Edit Note',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () async {
                await FirebaseFirestore.instance.collection('notes').doc(Get.arguments['docId'].toString()).update(
                    {
                      'note' : editNoteController.text.trim(),
                    }).then((value) => {
                      Fluttertoast.showToast(msg: "Updated Successfully !"),
                  Get.offAll(const HomeScreen()),
                });
              },
              child: const Padding(
            padding: EdgeInsets.symmetric(horizontal:105),
            child: Text("Update",style: TextStyle(fontSize: 20),),
          )),
        ],
      ),
    );
  }
}
