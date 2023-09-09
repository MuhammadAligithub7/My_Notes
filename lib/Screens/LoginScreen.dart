import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/Screens/ForgotPasswodScreen.dart';
import 'package:note_app/Screens/HomeScreen.dart';
import 'package:note_app/Screens/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  bool obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 400.0,
              child: Lottie.asset("assets/animation_llbx5481.json"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal:25),
              child: TextFormField(
                controller: userEmailController,
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal:25),
              child: TextFormField(
                controller: userPasswordController,
                obscureText: obscureText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Enter Password',
                  suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: obscureText ? const Icon(Icons.visibility_rounded) : const Icon(Icons.visibility_off_outlined) ),
                  prefixIcon: const Icon(Icons.password),
                ),

              ),
            ),
            const SizedBox(height: 3.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: (){
                      Get.to(const ForgotPasswodScreen());
                    },
                    child: const Card(
                      color: Colors.purple,
                      child:  Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Forgot Password",style: TextStyle(
                            color: Colors.white)),
                      ),
                    ),
                  ),
              ),
            ),
            ElevatedButton(
                onPressed: () async{
                  var userEmail = userEmailController.text.trim();
                  var userPassword = userPasswordController.text.trim();
                  EasyLoading.show();
                  try{
                    final User? firebaseuser = (
                        await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPassword)).user;
                    if(firebaseuser !=null) {
                      Get.to(const HomeScreen());
                      Fluttertoast.showToast(msg: "Login Successfully !");
                      EasyLoading.dismiss();
                    }
                  }on FirebaseAuthException catch(e) {
                    Fluttertoast.showToast(msg: '$e');
                    EasyLoading.dismiss();
                  }
                },
                child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 106),
              child: Text("Login",style: TextStyle(fontSize: 20),),
            )),
            const SizedBox(height: 3.0,),
            GestureDetector(
              onTap: (){
                Get.to(const SignupScreen());
              },
              child: const Card(
                color: Colors.purple,
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Don't have account SignUp !",style: TextStyle(
                    color: Colors.white,fontSize: 19)
                  ),
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


