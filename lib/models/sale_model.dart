/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class Sale {
  final String saleId;
  final DateTime date;
  final String userId;
  final double value;

  Sale({
    required this.saleId,
    required this.date,
    required this.userId,
    this.value = 0.0,
  });
}
