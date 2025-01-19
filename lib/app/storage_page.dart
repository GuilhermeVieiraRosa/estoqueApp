/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estoque_app/app/add_page.dart';
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
                onLongPress: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black54,
                    builder: (BuildContext context) {
                      return Center(
                        child: Container(
                          width: 300,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Mostra ID
                              Text('Id do Produto: ${product.productId}',
                                  style: TextStyle(fontSize: 18)),
                              const SizedBox(height: 12),

                              // Opção Editar
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  print('Editar ${product.name} selecionado');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddPage(
                                                isNew: false,
                                                product: product,
                                              )));
                                },
                                icon: Icon(Icons.edit, color: Colors.white),
                                label: Text(
                                  'Editar ${product.name}',
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Opção Apagar
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  print('Apagar ${product.name} selecionado');
                                  firestoreServices.deleteProduct(product);
                                },
                                icon: Icon(Icons.delete, color: Colors.white),
                                label: Text(
                                  'Apagar ${product.name}',
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
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
