/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

import 'package:estoque_app/models/product_model.dart';
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

  const MyBoxListComponent({
    super.key,
    required this.product,
    required this.onLongPress,
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
                      Text(
                        product.name,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),

                      // Descrição
                      Expanded(
                        // Ajusta o espaço vertical para o texto descritivo
                        child: Text(
                          product.description,
                          softWrap: true,
                          maxLines: 4, // Limita a altura do texto
                          overflow: TextOverflow
                              .ellipsis, // Substitui `visible` por `ellipsis` para evitar overflow
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
                        onChanged: (quantity) {},
                      ),
                      const SizedBox(height: 12),

                      // Botão Comprar
                      MyBuyButton(
                        onPressed: () {},
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
