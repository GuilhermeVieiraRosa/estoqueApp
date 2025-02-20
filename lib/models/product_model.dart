/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class Product {
  String productId;
  String name;
  String description;
  String imagePath;
  String price;
  String quantity;
  String administratorId;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.quantity,
    required this.administratorId,
  });

  // Converte um Map<String, dynamic> para um objeto Product
  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      productId: data['productId'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imagePath: data['imagePath'] ?? '',
      price: data['price'] ?? '',
      quantity: data['quantity'] ?? '',
      administratorId: data['administratorId'] ?? '',
    );
  }
}
