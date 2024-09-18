import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/components/CustomButton.dart';
import 'package:project/components/customTextFormField.dart';
import 'package:project/contants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project/helper/showSnackBar.dart';

// ignore: must_be_immutable
class Registerpage extends StatefulWidget {
  Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor, // in constant file
        body: Padding(
          padding:const EdgeInsets.only(right: 10, left: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(
                  flex: 4,
                ),
                Image.asset(logoForApp),  // variable in constant file,
               const Spacer(
                  flex: 1,
                ),
               const Text(
                  "Scholar Chat",
                  style: TextStyle(
                      fontSize: 32,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            blurRadius: 100,
                            offset: Offset(2, 2))
                      ],
                      color: Colors.white,
                      fontFamily: 'pacifico'),
                ),
                const Spacer(
                  flex: 3,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child:const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                CustomtextFormfield(
                  onChange: (data) => email = data,
                  hintText: "Email",
                ),
               const Spacer(
                  flex: 1,
                ),
                CustomtextFormfield(
                    onChange: (data) => password = data, hintText: "Password"),
               const Spacer(
                  flex: 2,
                ),
                Custombutton(
                  ButtonText: "REGISTER",
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      isloading = true; // loading sign
                      setState(() {});
                      try {
                        // ignore: unused_local_variable
                        UserCredential use = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email!,
                                password: password!); // refactor for code
                        showSnackBar(context,"Success"); // itis function saved in helper folder
                        Navigator.pushNamed(context, 'chatPage',arguments: email);   // go to chat screen after register
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, "this is weak password");
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,"The account already exists for that email");
                        }
                      } catch (e) {
                        showSnackBar(context, "There is an error");
                      }
                      isloading = false;
                      setState(() {});
                    } else {
                      showSnackBar(context, 'please enter correct data');
                    }
                  },
                ),
               const Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account         ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                
                      },
                      child:const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
             const   Spacer(flex: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
