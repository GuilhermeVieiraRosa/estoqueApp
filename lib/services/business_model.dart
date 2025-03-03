/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estoque_app/models/cart_model.dart';
import 'package:estoque_app/models/delivery_model.dart';
import 'package:estoque_app/models/product_model.dart';
import 'package:estoque_app/models/sale_model.dart';
import 'package:estoque_app/models/user_model.dart';
import 'package:flutter/material.dart';

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
  final CollectionReference tableCart =
      FirebaseFirestore.instance.collection('Cart');
  final CollectionReference tableSale =
      FirebaseFirestore.instance.collection('Sale');
  final CollectionReference tableDelivery =
      FirebaseFirestore.instance.collection('Delivery');

  /*********************************************************
  *   Methods
  *********************************************************/
  /*
   * PRODUCT MODEL
   */
  // CREATE PRODUCT
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

  // UPDATE PRODUCT
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

  Future<void> removeFromStorage(String productId, String quantity) async {
    Product? product = await getProduct(productId);

    if (product != null) {
      product.quantity =
          (int.parse(product.quantity) - (int.parse(quantity))).toString();
      updateProduct(product);
    }
  }

  // DELETE PRODUCT
  Future<void> deleteProduct(Product product) {
    return tableProduct.doc(product.productId).delete();
  }

  // READ PRODUCT
  Stream<QuerySnapshot> getProductStream() {
    return tableProduct.orderBy('name', descending: false).snapshots();
  }

  Future<Product?> getProduct(String productId) async {
    print('**************** procurando produto $productId');
    var snapshot =
        await tableProduct.where('productId', isEqualTo: productId).get();

    if (snapshot.docs.isEmpty) {
      print('**************** produto não encontrado');
      return null; // Retorna null se não encontrar usuário
    }

    var data = snapshot.docs.first.data() as Map<String, dynamic>;
    return Product?.fromMap(data); // Converte os dados para um objeto User
  }

  Future<String?> getProductIdByName(String name) async {
    var snapshot = await tableProduct.where('name', isEqualTo: name).get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    var data = snapshot.docs.first.data() as Map<String, dynamic>;
    var product = Product?.fromMap(data);
    return product.productId;
  }

  /*
   * CART MODEL
   */
  // CREATE CART
  Future<void> addCart(Cart cart) {
    return tableCart.doc(cart.cartId).set({
      'cartId': cart.cartId,
      'productId': cart.productId,
      'userId': cart.userId,
      'quantity': cart.quantity,
    });
  }

  // READ CART
  Stream<QuerySnapshot> getCartStream(UserData user) {
    print('***************** prcurando carrinho de userId: ${user.userId}');
    return tableCart
        .where('userId', isEqualTo: user.userId)
        .orderBy('productId', descending: false)
        .snapshots();
  }

  // UPDATE CART
  Future<void> updateCart(Cart cart) {
    return tableCart.doc(cart.cartId).update({
      'cartId': cart.cartId,
      'productId': cart.productId,
      'userId': cart.userId,
      'quantity': cart.quantity,
    });
  }

  // DELETE CART
  Future<void> deleteCart(Cart cart) {
    return tableCart.doc(cart.cartId).delete();
  }

  Future<void> deleteUserCart(UserData user) async {
    QuerySnapshot querySnapshot =
        await tableCart.where('userId', isEqualTo: user.userId).get();

    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  // CART METHODS
  // Create new cart var
  Cart createCart(Product product, UserData user, String quantity) {
    var cart = Cart(
        cartId: '${user.userId}.${product.productId}',
        productId: product.productId,
        userId: user.userId,
        quantity: quantity);
    return cart;
  }

  /* 
   * USER MODEL
   */
  // CREATE USER
  Future<void> addUser(UserData user) {
    return tableUser.doc(user.userId).set({
      'userId': user.userId,
      'name': user.name,
      'email': user.email,
      'isAdmin': user.isAdmin,
    });
  }

  // READ USER
  Future<UserData?> getUser(String? email) async {
    if (email == null) {
      print('**************** email nulo');
      return null;
    }

    print('**************** procurando email $email');
    var snapshot = await tableUser.where('email', isEqualTo: email).get();

    if (snapshot.docs.isEmpty) {
      print('**************** usuário não encontrado');
      return null; // Retorna null se não encontrar usuário
    }

    var data = snapshot.docs.first.data() as Map<String, dynamic>;
    return UserData?.fromMap(data); // Converte os dados para um objeto User
  }

  Future<String?> getUserIdByName(String? name) async {
    if (name == null) {
      return null;
    }

    var snapshot = await tableUser.where('name', isEqualTo: name).get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    var data = snapshot.docs.first.data() as Map<String, dynamic>;
    return data['userId'];
  }

  Stream<QuerySnapshot> getUserStreamByName() {
    return tableUser
        .where('isAdmin', isEqualTo: false)
        .orderBy('name', descending: false)
        .snapshots();
  }

  // UPDATE USER

  // DELETE USER

  // USER METHODS
  // Create new user
  Future<void> newUser(String email, String name) async {
    var user = UserData(
        userId: await generateUserId(),
        name: name,
        email: email,
        isAdmin: false);

    return addUser(user);
  }

  // Generate User id
  Future<String> generateUserId() async {
    var snapshot = await tableUser.orderBy('userId', descending: true).get();

    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs.first.data() as Map<String, dynamic>;

      return '${int.parse(data['userId']) + 1}';
    } else {
      return '0';
    }
  }

  /* 
   * SALE MODEL
   */
  // CREATE SALE
  Future<void> addSale(Sale sale) {
    return tableSale.doc(sale.saleId).set({
      'saleId': sale.saleId,
      'userId': sale.userId,
      'date': sale.date,
    });
  }

  // SALE METHODS
  // Create new sale
  Future<Sale> newSale(String userId) async {
    var sale = Sale(
        saleId: await generateSaleId(),
        userId: userId,
        date: DateTime.timestamp());

    addSale(sale);
    return sale;
  }

  // Generate Sale id
  Future<String> generateSaleId() async {
    var snapshot = await tableSale.orderBy('saleId', descending: true).get();

    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs.first.data() as Map<String, dynamic>;

      return '${int.parse(data['saleId']) + 1}';
    } else {
      return '0';
    }
  }

  // READ SALE
  Future<String?> getSalesTimeStamp(String saleId) async {
    var snapshot = await tableSale.where('saleId', isEqualTo: saleId).get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    var data = snapshot.docs.first.data() as Map<String, dynamic>;
    DateTime timestamp = data['date'].toDate();
    return timestamp.toString();
  }

  Stream<QuerySnapshot> getSaleStreamByUserId(String userId) {
    return tableSale.where('userId', isEqualTo: userId).snapshots();
  }

  /* 
   * DELIVERY MODEL
   */
  // CREATE DELIVERY
  Future<void> addDelivery(Delivery delivery) {
    return tableDelivery.doc(delivery.deliveryId).set({
      'deliveryId': delivery.deliveryId,
      'productId': delivery.productId,
      'saleId': delivery.saleId,
      'quantity': delivery.quantity,
    });
  }

  // Create new sale
  Future<Delivery> newDelivery(
      Sale sale, String productId, String quantity) async {
    var delivery = Delivery(
        deliveryId: '${sale.saleId}.$productId',
        saleId: sale.saleId,
        productId: productId,
        quantity: quantity);

    addDelivery(delivery);
    return delivery;
  }

  Future<void> buyMethod(
      UserData user, List<DocumentSnapshot> cartSnapshotList) async {
    Sale sale = await newSale(user.userId);
    int index = 0;

    for (index = 0; index < cartSnapshotList.length; index++) {
      Map<String, dynamic> cartData =
          cartSnapshotList[index].data() as Map<String, dynamic>;
      var cart = Cart(
        cartId: cartData['cartId'],
        productId: cartData['productId'],
        userId: cartData['userId'],
        quantity: cartData['quantity'],
      );
      await newDelivery(sale, cart.productId, cart.quantity);
      await removeFromStorage(cart.productId, cart.quantity);
    }

    deleteUserCart(user);
  }

  Stream<QuerySnapshot> getDeliveryStreamByProductId(String productId) {
    return tableDelivery.where('productId', isEqualTo: productId).snapshots();
  }

  Stream<QuerySnapshot> getDeliveryStreamBySaleId(String saleId) {
    return tableDelivery.where('saleId', isEqualTo: saleId).snapshots();
  }
}

class UserProvider with ChangeNotifier {
  String _role = 'user'; // Valor padrão para usuário comum

  String get role => _role;

  void setRole(String isAdmin) {
    if (isAdmin == 'true') {
      _role = 'admin';
    } else {
      _role = 'user';
    }
    notifyListeners();
  }
}
