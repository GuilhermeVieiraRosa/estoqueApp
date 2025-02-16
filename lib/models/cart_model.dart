/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class Cart {
  final String cartId;
  final String productId;
  final String userId;
  final String quantity;

  Cart({
    required this.cartId,
    required this.productId,
    required this.userId,
    required this.quantity,
  });
}
