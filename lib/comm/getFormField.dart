import 'package:flutter/material.dart';

class GetTextFormField extends StatelessWidget {
   TextEditingController controller;
   String hintName;
   IconData iconData;
   TextInputType textInputType;

   GetTextFormField({
   required this.controller, 
   required this.hintName,
    required this.iconData, 
  this.textInputType = TextInputType.text, required String? Function(dynamic value) validator,
   });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
              keyboardType: textInputType,
              decoration: InputDecoration(
                prefixIcon: Icon(iconData),
                hintText: hintName,
                labelText: "Please Enter $hintName",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter $hintName";
                }
              }
                  
            );
  }
}