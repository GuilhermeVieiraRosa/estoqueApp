/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

import 'package:estoque_app/models/cart_model.dart';
import 'package:estoque_app/models/product_model.dart';
import 'package:estoque_app/services/business_model.dart';
import 'package:estoque_app/ui/qtty_selector_button_component.dart';
import 'package:flutter/material.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class MyCartListComponent extends StatefulWidget {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/
  Cart cart;
  Product product;

  MyCartListComponent({
    Key? key,
    required this.cart,
    required this.product,
  });

  final FirestoreServices firestoreServices = FirestoreServices();

  @override
  State<MyCartListComponent> createState() => _MyCartListComponentState();
}

class _MyCartListComponentState extends State<MyCartListComponent> {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/
  final mainHeight = 80.0;
  double partialValue = 0;

  /*********************************************************************************************************************
  *   Build
  *********************************************************************************************************************/
  @override
  void initState() {
    super.initState();
    initQuantityState(); // Inicializa o cálculo do partialValue
  }

  void initQuantityState() {
    setState(() {
      int quantity = int.tryParse(widget.cart.quantity) ?? 0;
      double price =
          double.tryParse(widget.product.price.replaceAll(',', '.')) ?? 0;
      partialValue = (quantity * price).toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
      child: Container(
        height: mainHeight,
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Imagem e Nome do Produto (esquerda)
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      width: mainHeight,
                      height: mainHeight,
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.product.imagePath),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Preço, Quantidade e Botão (direita)
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Preço
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "R\$ ${widget.product.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        // Quantidade
                        SizedBox(
                          width: 60,
                          child: MyQttySelectorComponent(
                            initialQuantity:
                                int.tryParse(widget.cart.quantity) ?? 1,
                            onChanged: (newQuantity) {
                              if (newQuantity != 0) {
                                widget.cart.quantity = newQuantity.toString();
                                widget.firestoreServices
                                    .updateCart(widget.cart);
                              } else {
                                widget.firestoreServices
                                    .deleteCart(widget.cart);
                              }
                              initQuantityState();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 12),

                  // Preço
                  Text(
                    "R\$ ${partialValue.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
