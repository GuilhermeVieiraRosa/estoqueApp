/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

import 'package:estoque_app/models/product_model.dart';
import 'package:estoque_app/models/user_model.dart';
import 'package:estoque_app/services/business_model.dart';
import 'package:estoque_app/ui/button_buy_component.dart';
import 'package:estoque_app/ui/qtty_selector_button_component.dart';
import 'package:flutter/material.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class MyBoxListComponent extends StatelessWidget {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/
  final Product product;
  final VoidCallback onLongPress;
  var quantity = 1;
  UserData user;

  MyBoxListComponent({
    super.key,
    required this.product,
    required this.onLongPress,
    UserData? user,
  }) : user = user ?? UserData(userId: '', name: '', email: '', isAdmin: false);

  final FirestoreServices firestoreServices = FirestoreServices();

  /*********************************************************************************************************************
  *   Methods
  *********************************************************************************************************************/

  /*********************************************************************************************************************
  *   Build
  *********************************************************************************************************************/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
        child: Container(
          height: 150,
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  image: NetworkImage(product.imagePath),
                ),
              ),

              // Texto
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome
                      Row(
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            product.quantity,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12.0),
                          ),
                        ],
                      ),

                      // Descrição
                      Expanded(
                        // Ajusta o espaço vertical para o texto descritivo
                        child: Text(
                          product.description,
                          softWrap: true,
                          maxLines: 4, // Limita a altura do texto
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 0,
                child: SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      // Preço
                      Text(
                        "R\$ ${product.price}",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 12),

                      // Quantidade
                      MyQttySelectorComponent(
                        initialQuantity: 1,
                        onChanged: (newQuantity) {
                          quantity = newQuantity;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Botão Comprar
                      MyBuyButton(
                        onPressed: () {
                          firestoreServices.addCart(firestoreServices
                              .createCart(product, user, quantity.toString()));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
