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
}
