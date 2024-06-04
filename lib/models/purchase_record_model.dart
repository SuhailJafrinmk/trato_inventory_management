import 'package:trato_inventory_management/models/purchased_item.dart';

class PurchaseRecord{
  String? id;
  final String supplierName;
  final String supplierEmail;
  final String purchaseDate;
  final List<PurchasedItem> items;
  final int totalAmount;
  PurchaseRecord({this.id, required this.purchaseDate, required this.items, required this.totalAmount,required this.supplierEmail,required this.supplierName});


Map<String,dynamic>toMap(){
  return {
    // 'id':id,
    'supplierName':supplierName,
    'supplierEmail':supplierEmail,
    'purchaseDate':purchaseDate,
    'items': items.map((item) => item.toMap()).toList(),
    'totalAmount':totalAmount,
  };
}


}

