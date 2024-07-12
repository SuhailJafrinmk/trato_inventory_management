

class SelledItem{
  final String productName;
  final String supplierName;
  final int quantity;
  final int price;
  final int totalItemAmount;

  SelledItem({required this.productName,required this.supplierName,required this.quantity, required this.price, required this.totalItemAmount}); 

  Map<String,dynamic> toMap(){
    return {
      'productName':productName,
      'supplierName':supplierName,
      'quantity':quantity,
      'price':price,
      'totalItemAmount':totalItemAmount,
    };
  }

  factory SelledItem.fromMap(Map<String,dynamic>data){
    return SelledItem(
    productName: data['productName'],
    supplierName: data['supplierName'],
    quantity: data['quantity'],
    price: data['price'],
    totalItemAmount: data['totalItemAmount']);
  }

}