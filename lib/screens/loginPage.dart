import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project/components/CustomButton.dart';
import 'package:project/components/customTextFormField.dart';
import 'package:project/contants.dart';
import 'package:project/helper/showSnackBar.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor:
            kPrimaryColor, // const variable saved into constant file in lib folder
        body: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
              const  Spacer(
                  flex: 4,
                ),
                Image.asset(
                  logoForApp,  // variable in constant file
                  height: 100,
                ),
               const Spacer(
                  flex: 1,
                ),
                const Text(
                  "Scholar Chat",
                  style: TextStyle(shadows: [
                    Shadow(
                        color: Colors.black,
                        blurRadius: 100,
                        offset: Offset(2, 2))
                  ], fontSize: 32, color: Colors.white, fontFamily: 'pacifico'),
                ),
               const Spacer(
                  flex: 3,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child:const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
            const    Spacer(
                  flex: 1,
                ),
                CustomtextFormfield(
                  onChange: (data) {
                    email = data;
                  },
                  hintText: "Email",
                ),
                const Spacer(
                  flex: 1,
                ),
                CustomtextFormfield(
                    onChange: (data) {
                      password = data;
                    },
                    hintText: "Password"),
               const Spacer(
                  flex: 2,
                ),
                Custombutton(
                  ButtonText: "LOGIN",
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      isloading = true; // loading sign
                      setState(() {});
                      try {
                        // ignore: unused_local_variable
                        UserCredential use = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email!, password: password!);
                        // ignore: use_build_context_synchronously
                        showSnackBar(context, "Success");
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, 'chatPage',arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          // ignore: use_build_context_synchronously
                          showSnackBar(context, "The account Not Found");
                        } else if (e.code == 'wrong-password') {
                          // ignore: use_build_context_synchronously
                          showSnackBar(context, "Wrong password");
                        }
                        
                      }
                      isloading = false;
                      setState(() {});
                    }
                  },
                ),
              const  Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 const   Text(
                      "Dont have an account?     ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegisterPage');
                      },
                      child:const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
               const Spacer(flex: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
