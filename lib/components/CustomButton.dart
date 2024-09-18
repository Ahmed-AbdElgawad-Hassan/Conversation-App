import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Custombutton extends StatelessWidget {
  VoidCallback? ontap;
  String? ButtonText;
   Custombutton({required this.ButtonText, this.ontap,  Future<Null> Function()? onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:ontap ,
      child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                 child: Text("$ButtonText",
                style:const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w900
                ),)
              ),
    );
          
  }
}