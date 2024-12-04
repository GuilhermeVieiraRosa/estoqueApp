/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

import 'dart:ui';

import 'package:flutter/material.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class MyButtonComponent extends StatelessWidget {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/

  final Function()? onTap;
  final String text;

  MyButtonComponent({
    super.key,
    required this.onTap,
    required this.text,
  });

  /*********************************************************************************************************************
  *   Methods
  *********************************************************************************************************************/

  /*********************************************************************************************************************
  *   Build
  *********************************************************************************************************************/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
