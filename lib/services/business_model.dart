/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estoque_app/models/product_model.dart';
import 'package:estoque_app/models/user_model.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/
class FirestoreServices {
  /*********************************************************
  *   Variables
  *********************************************************/
  /* PRODUTO */
  // Inicializar Firebase
  final CollectionReference tableProduct =
      FirebaseFirestore.instance.collection('Product');
  final CollectionReference tableSell =
      FirebaseFirestore.instance.collection('Sell');
  final CollectionReference tableUser =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference tableAdmin =
      FirebaseFirestore.instance.collection('Admin');
  final CollectionReference tableProductSale =
      FirebaseFirestore.instance.collection('ProductSale');

  /*********************************************************
  *   Methods
  *********************************************************/
  // Criar produto
  Future<void> addProduct(Product product) {
    return tableProduct.doc(product.productId).set({
      'productId': product.productId,
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'quantity': product.quantity,
      'imagePath': product.imagePath,
      'administratorId': product.administratorId,
    });
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

  // Ver produto
  Stream<QuerySnapshot> getProductStream() {
    return tableProduct.orderBy('name', descending: false).snapshots();
  }

  /* CARRINHO */
  // Adicionar ao carrinho
  Future<void> addCart(Product product, User user, String quantity) {
    return tableProductSale.doc(product.productId + user.userId).set({
      'cartId': product.productId + user.userId,
      'productId': product.productId,
      'userId': user.userId,
      'quantity': quantity,
    });
  }

  /* USUÁRIO */
  // Rotina de novo usuário
  Future<void> newUser(String email) async {
    String userId = await generateUserId();

    return tableUser.doc(userId).set({
      'userId': userId,
      'email': email,
    });
  }

  // Gera novo Id de usuário
  Future<String> generateUserId() async {
    var snapshot = await tableUser.orderBy('userId', descending: true).get();

    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs.first.data() as Map<String, dynamic>;

      return '${int.parse(data['userId']) + 1}';
    } else {
      return '0';
    }
  }
}
