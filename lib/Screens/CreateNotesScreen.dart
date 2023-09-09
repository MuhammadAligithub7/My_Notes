import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:note_app/Screens/HomeScreen.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({super.key});

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {

  TextEditingController noteController = TextEditingController();
  User? userid = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Notes"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal:5),
              child: TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Write Here',
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
                var note = noteController.text.trim();

                if(note != " "){
                  try{
                    await FirebaseFirestore.instance.collection("notes").doc().set({
                      'createdAt' : DateTime.now(),
                      'note' : note,
                      'userId' : userid?.uid,
                    });
                  }on FirebaseAuthException catch (e)
                {
                  Fluttertoast.showToast(msg: '$e');
                }
                  Fluttertoast.showToast(msg: "Your Note has been Added !");
                  Get.off(const HomeScreen());
                }

              }, child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 95),
            child: Text("Add Note",style: TextStyle(fontSize: 20),),
          )),
        ],
      ),
    );
  }
}
