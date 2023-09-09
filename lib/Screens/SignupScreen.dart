import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/Services/SignupServices.dart';
import 'LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  bool obscureText = true;

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SignUp'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 220.0,
              child: Lottie.asset("assets/animation_llbx5481.json"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal:25),
              child: TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'User Name',
                  prefixIcon: const Icon(Icons.person),
                ),

              ),
            ),
            const SizedBox(height: 10.0,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal:25),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: userPhoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Phone',
                  prefixIcon: const Icon(Icons.phone),
                ),

              ),
            ),
            const SizedBox(height: 10.0,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal:25),
              child: TextFormField(
                controller: userEmailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Email',
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
                          obscureText =! obscureText;
                        });
                      },
                      child: obscureText ? const Icon(Icons.visibility_rounded) : const Icon(Icons.visibility_off_rounded) ),
                  prefixIcon: const Icon(Icons.password),
                ),

              ),
            ),
            const SizedBox(height: 10.0,),
            ElevatedButton(
                onPressed: () async{
                  var userName = userNameController.text.trim();
                  var userPhone = userPhoneController.text.trim();
                  var userEmail = userEmailController.text.trim();
                  var userPassword  = userPasswordController.text.trim();
                  EasyLoading.show();

                  if(userName.isEmpty || userPhone.isEmpty || userEmail.isEmpty || userPassword.isEmpty)
                    {
                      Fluttertoast.showToast(msg: 'Fill All the Fields !');
                      EasyLoading.dismiss();
                    }
                     await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: userEmail, password: userPassword).then((value) =>  {
                        signUpUser(userName, userPhone, userEmail, userPassword),
                     });
                  Fluttertoast.showToast(msg: "Registered Successfully!");
                  EasyLoading.dismiss();
                  }, child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 97),
              child: Text("SignUp",style: TextStyle(fontSize: 20),),
            )),


            GestureDetector(
              onTap: (){
                Get.to(const LoginScreen());
              },
              child: const Card(
                color: Colors.purple,
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Already have an account Login !",style: TextStyle(
                      color: Colors.white,fontSize: 18)
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

