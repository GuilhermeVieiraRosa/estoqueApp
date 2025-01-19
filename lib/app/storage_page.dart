/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estoque_app/models/product_model.dart';
import 'package:estoque_app/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:estoque_app/ui/boxlist_component.dart';
//Paginas
//Componentes

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class StoragePage extends StatelessWidget {
  /*********************************************************
  *   Variables
  *********************************************************/

  var product = Product(
      productId: 'productId',
      name: 'name',
      description: 'description',
      imagePath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxoTUcfO6YNrYPu3p59hPsniPYf28NmbeI1A&s',
      price: 'price',
      quantity: 'quantity',
      administratorId: 'administratorId');

  StoragePage({super.key});

  final FirestoreServices firestoreServices = FirestoreServices();

  /*********************************************************
  *   Methods
  *********************************************************/

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    // Steam para manter atualizado caso ocorra mundança no banco de dados
    return StreamBuilder(
      stream: firestoreServices.getProductStream(),
      builder: (context, snapshot) {
        // Verifica se tem dados
        if (snapshot.hasData) {
          // Coleta lista de dados
          List productList = snapshot.data!.docs;

          // Mostra todos os dado como lista
          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              // Coleta dado individualmente
              DocumentSnapshot productSnapshot = productList[index];
              Map<String, dynamic> productData =
                  productSnapshot.data() as Map<String, dynamic>;
              var product = Product(
                  productId: productData['productId'],
                  name: productData['name'],
                  description: productData['description'],
                  imagePath: productData['imagePath'],
                  price: productData['price'],
                  quantity: productData['quantity'],
                  administratorId: productData['administratorId']);

              // Mostra dado individualmente
              return MyBoxListComponent(
                product: product,
                onTap: null,
              );
            },
          );
        } else {
          // Se não tem dados mostra mensagem
          return Center(child: Text('Mercado Vazio!'));
        }
      },
    );
  }
}
