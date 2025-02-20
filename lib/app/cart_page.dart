import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//Paginas
import 'package:estoque_app/app/cartlist_page.dart';
//Componentes
import 'package:estoque_app/ui/button_component.dart';
// Modelos
import 'package:estoque_app/models/user_model.dart';
import 'package:estoque_app/services/business_model.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/
class CartPage extends StatelessWidget {
  /*********************************************************
  *   Variables
  *********************************************************/
  UserData user;

  CartPage({
    super.key,
    UserData? user,
  }) : user = user ?? UserData(userId: '', name: '', email: '', isAdmin: false);

  final FirestoreServices firestoreServices = FirestoreServices();

  /*********************************************************
  *   Build
  *********************************************************/
  Future<int> buyCart(UserData user) async {
    int result = 0;
    try {
      QuerySnapshot cartSnapshot = await firestoreServices
          .getCartStream(user)
          .first; // Pega o primeiro snapshot do stream

      await firestoreServices.buyMethod(user, cartSnapshot.docs);
    } catch (e) {
      print("Erro ao processar a compra: $e");
      result = 1;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // - Moldura da página
    return Scaffold(
      // -- Barra Superior
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.w900,
          fontSize: 26,
        ),
      ),

      // Conteúdo da Página
      body: Column(
        children: [
          // Lista de Produtos no Carrinho
          CartListPage(
            user: user,
          ),

          // Botão Finalizar Compra
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: MyButtonComponent(
                onTap: () async {
                  int success = await buyCart(user);

                  if (success == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Compra finalizada com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao finalizar compra!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                text: 'Finalizar Compra'),
          ),
        ],
      ),
    );
  }
}
