/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

import 'package:flutter/material.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class MyTextfieldComponent extends StatelessWidget {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/

  final dynamic controller;
  final String hintText;
  final bool obscureText;

  const MyTextfieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  /*********************************************************************************************************************
  *   Methods
  *********************************************************************************************************************/

  /*********************************************************************************************************************
  *   Build
  *********************************************************************************************************************/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
