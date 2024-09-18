import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomtextFormfield extends StatelessWidget {
  Function(String)? onChange;
  String? hintText;
   CustomtextFormfield({super.key, required this.hintText,this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:(data)
      {
        if(data!.isEmpty)
        {
          return 'This Field is required';
        }
        return null;
      },
             onChanged:onChange ,
             style:const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold
             ),
            decoration: InputDecoration(
              hintText: "$hintText",
              hintStyle:const TextStyle(
                color: Colors.white
              ),
              focusedBorder:const OutlineInputBorder(
                 borderSide: BorderSide(
                  color: Colors.white
                )
              ) ,
              enabledBorder:const OutlineInputBorder(
                 borderSide: BorderSide(
                  color: Colors.white
                )
               
              )
            ),
          );
  }
}