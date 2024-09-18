import 'package:flutter/material.dart';
import 'package:project/models/message.dart';

// ignore: must_be_immutable
class Customchatbubbleforfreind extends StatelessWidget {
   Customchatbubbleforfreind({super.key,required this.message});
  Message message ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:  const EdgeInsets.all(20),
        margin:const EdgeInsets.all(10),
        decoration:const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        child: Text(
          message.text,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
