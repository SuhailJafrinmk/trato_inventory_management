
import 'package:trato_inventory_management/models/selled_item.dart';

class SalesRecordModel{
  String? id;
  final String customerName;
  final String customerEmail;
  final String saleDate;
  final List<SelledItem> items;
  final int totalAmount;
  SalesRecordModel({this.id, required this.saleDate, required this.items, required this.totalAmount,required this.customerEmail,required this.customerName});


Map<String,dynamic>toMap(){
  return {
    'customerName':customerName,
    'customerEmail':customerEmail,
    'saleDate':saleDate,
    'items': items.map((item) => item.toMap()).toList(),
    'totalAmount':totalAmount,
  };
}


}
