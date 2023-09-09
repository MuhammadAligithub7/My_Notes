import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:note_app/Screens/CreateNotesScreen.dart';
import 'package:note_app/Screens/EditNoteScreen.dart';

import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('My Notes'),
        actions: [
          IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Get.defaultDialog(
              title: "Logout",
              titlePadding: const EdgeInsets.only(top: 20),
              contentPadding: const EdgeInsets.all(10),
              middleText: "Do You Want To Logout !",
              confirm: TextButton(onPressed: (){
                FirebaseAuth.instance.signOut();
                Get.off(const LoginScreen());
                Fluttertoast.showToast(msg: "Logout Successfully !");
              }, child: const Text("Yes")),
              cancel: TextButton(onPressed: (){
                Get.back();
              }, child: const Text("No")),
            );
          },
        ),
        ],
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("notes").where("userId", isEqualTo: userId?.uid ).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.connectionState  == ConnectionState.waiting)
        {
          return const Center(
            child: CupertinoActivityIndicator(color: Colors.purple,),
          );
        }

        if (snapshot.data!.docs.isEmpty)
        {
          const Center(child: Text("Data Not Found !"));
        }

        if (snapshot.data != null)
        {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                var note = snapshot.data!.docs[index]['note'];
                var docId = snapshot.data!.docs[index].id;
                return Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(snapshot.data!.docs[index]['note']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.to(const EditNoteScreen(),arguments:
                              {
                                'note' : note,
                                'docId' : docId,
                              });
                            },
                            child: const Icon(Icons.mode_edit_outline,color: Colors.purple,)),
                        const SizedBox(width: 15),
                        GestureDetector(
                            onTap: () async{
                              FirebaseFirestore.instance.collection('notes').doc(docId).delete();
                            },
                            child: const Icon(Icons.delete_rounded,color: Colors.purple,)),
                      ],
                    ),
                  ),
                );
              });
        }
        return Container();
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: (){
        Get.to(const CreateNotesScreen());
      },
      child:  const Icon(Icons.add_circle_outlined),
      ),
    );
  }
}


