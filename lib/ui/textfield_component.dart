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
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        keyboardType: TextInputType.text,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          hintText: hintText,
          hintStyle:
              TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
        ),
      ),
    );
  }
}

class MyTextfieldComponentVariant extends StatelessWidget {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/

  final dynamic controller;
  final String text;
  final String hintText;
  final bool obscureText;

  const MyTextfieldComponentVariant({
    super.key,
    required this.controller,
    required this.text,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            '$text:',
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
          ),
        ),
        MyTextfieldComponent(
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
