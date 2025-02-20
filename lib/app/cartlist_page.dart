/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estoque_app/models/cart_model.dart';
import 'package:estoque_app/models/product_model.dart';
import 'package:estoque_app/models/user_model.dart';
import 'package:estoque_app/services/business_model.dart';
import 'package:estoque_app/ui/cartlist_component.dart';
import 'package:flutter/material.dart';
//Paginas
//Componentes
// Modelos

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/
class CartListPage extends StatelessWidget {
  /*********************************************************
  *   Variables
  *********************************************************/

  UserData user;

  CartListPage({
    super.key,
    UserData? user,
  }) : user = user ?? UserData(userId: '', name: '', email: '', isAdmin: false);

  final FirestoreServices firestoreServices = FirestoreServices();

  /*********************************************************
  *   Build
  *********************************************************/
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestoreServices.getCartStream(user),
      builder: (context, snapshot) {
        // Verifica se tem dados
        if (snapshot.hasData) {
          // Coleta lista de dados
          List cartList = snapshot.data!.docs;

          // Mostra todos os dados como lista
          return Expanded(
            child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                // Coleta dado individualmente
                DocumentSnapshot cartSnapshot = cartList[index];
                Map<String, dynamic> cartData =
                    cartSnapshot.data() as Map<String, dynamic>;
                var cart = Cart(
                  cartId: cartData['cartId'],
                  productId: cartData['productId'],
                  userId: cartData['userId'],
                  quantity: cartData['quantity'],
                );

                // Usa FutureBuilder para resolver o Future<Product?> e passar o valor
                return FutureBuilder<Product?>(
                  future: firestoreServices.getProduct(cart.productId),
                  builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Indicador de carregamento
                    }

                    if (productSnapshot.hasError) {
                      return Text(
                          'Erro: ${productSnapshot.error}'); // Exibe erro se houver
                    }

                    if (productSnapshot.hasData &&
                        productSnapshot.data != null) {
                      var product = productSnapshot.data!;

                      // Mostra dado individualmente
                      return MyCartListComponent(
                        cart: cart,
                        product: product,
                      );
                    } else {
                      return Text('Produto não encontrado');
                    }
                  },
                );
              },
            ),
          );
        } else {
          // Se não tem dados, mostra mensagem
          return Column(
            children: [
              const SizedBox(height: 50),
              Center(child: Text('Carrinho Vazio!')),
            ],
          );
        }
      },
    );
  }
}
