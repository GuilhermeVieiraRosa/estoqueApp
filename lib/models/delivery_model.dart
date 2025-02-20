/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class Delivery {
  final String deliveryId;
  final String saleId;
  final String productId;
  final String quantity;

  Delivery({
    required this.deliveryId,
    required this.saleId,
    required this.productId,
    required this.quantity,
  });
}
