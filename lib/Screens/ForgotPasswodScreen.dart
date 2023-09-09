import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/Screens/LoginScreen.dart';

class ForgotPasswodScreen extends StatefulWidget {
  const ForgotPasswodScreen({super.key});

  @override
  State<ForgotPasswodScreen> createState() => _ForgotPasswodScreenState();
}

class _ForgotPasswodScreenState extends State<ForgotPasswodScreen> {

  TextEditingController forgotPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 300.0,
              child: Lottie.asset("assets/animation_llbx5481.json"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal:25),
              child: TextFormField(
                controller: forgotPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Enter Email',
                  prefixIcon: const Icon(Icons.email),
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
                onPressed: ()async {
                  var forgotPassword = forgotPasswordController.text.trim();

                  try{
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotPassword).then((value) => {
                      Fluttertoast.showToast(msg: "Check Your Email !"),
                      Get.off(const LoginScreen()),
                    });
                  } on FirebaseAuthException catch(e) {
                    Fluttertoast.showToast(msg: '$e');
                  }
                }, child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: Text("Forgot Password",style: TextStyle(fontSize: 20),),
            )),
          ],
        ),
      ),
    );
  }
}
