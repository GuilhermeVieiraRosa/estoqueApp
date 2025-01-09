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

class MyQttySelectorComponent extends StatefulWidget {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/

  final int initialQuantity;
  final int minQuantity;
  final int maxQuantity;
  final ValueChanged<int> onChanged;

  const MyQttySelectorComponent({
    super.key,
    this.initialQuantity = 1,
    this.minQuantity = 1,
    this.maxQuantity = 99,
    required this.onChanged,
  });

  /*********************************************************************************************************************
  *   Methods
  *********************************************************************************************************************/

  /*********************************************************************************************************************
  *   Build
  *********************************************************************************************************************/

  @override
  State<MyQttySelectorComponent> createState() =>
      _MyQttySelectorComponentState();
}

class _MyQttySelectorComponentState extends State<MyQttySelectorComponent> {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/

  late int quantity;

  /*********************************************************************************************************************
  *   Methods
  *********************************************************************************************************************/

  @override
  void initState() {
    super.initState();
    quantity =
        widget.initialQuantity.clamp(widget.minQuantity, widget.maxQuantity);
  }

  void incrementQuantity() {
    setState(() {
      if (quantity < widget.maxQuantity) {
        quantity++;
        widget.onChanged(quantity);
      }
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > widget.minQuantity) {
        quantity--;
        widget.onChanged(quantity);
      }
    });
  }

  /*********************************************************************************************************************
  *   Build
  *********************************************************************************************************************/

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Botão de decremento
        GestureDetector(
          onTap: decrementQuantity,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey.shade200,
            child: Icon(
              Icons.remove,
              color: Colors.black,
              size: 16,
            ),
          ),
        ),

        // Quantidade
        Expanded(
          child: Center(
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Botão de incremento
        GestureDetector(
          onTap: incrementQuantity,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey.shade200,
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
