/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estoque_app/models/product_model.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/
class FirestoreServices {
  // Inicializar Firebase
  final CollectionReference tableProduct =
      FirebaseFirestore.instance.collection('Product');
  final CollectionReference tableSell =
      FirebaseFirestore.instance.collection('Sell');
  final CollectionReference tableUser =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference tableAdmin =
      FirebaseFirestore.instance.collection('Admin');
  final CollectionReference tableProductSell =
      FirebaseFirestore.instance.collection('ProductSell');

  // Criar produto
  Future<void> addProduct(Product product) {
    return tableProduct.add({
      'productId': product.productId,
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'quantity': product.quantity,
      'imagePath': product.imagePath,
      'administratorId': product.administratorId,
    });
  }

  // Ver produto
  Stream<QuerySnapshot> getProductStream() {
    final productStream =
        tableProduct.orderBy('productId', descending: true).snapshots();

    return productStream;
  }

  // Atualizar produto
  Future<void> updateProduct(Product product) {
    return tableProduct.doc(product.productId).update({
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'quantity': product.quantity,
      'imagePath': product.imagePath,
      'administratorId': product.administratorId,
    });
  }

  // Deletar produto
  Future<void> deleteProduct(Product product) {
    return tableProduct.doc(product.productId).delete();
  }
}
