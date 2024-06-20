import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trato_inventory_management/models/purchased_item.dart';

class PurchaseRecord{
  String? id;
  final String supplierName;
  final String supplierEmail;
  final Timestamp purchaseDate;
  final List<PurchasedItem> items;
  final int totalAmount;
  PurchaseRecord({this.id, required this.purchaseDate, required this.items, required this.totalAmount,required this.supplierEmail,required this.supplierName});


Map<String,dynamic>toMap(){
  return {
    'supplierName':supplierName,
    'supplierEmail':supplierEmail,
    'purchaseDate':purchaseDate,
    'items': items.map((item) => item.toMap()).toList(),
    'totalAmount':totalAmount,
  };
}
}

