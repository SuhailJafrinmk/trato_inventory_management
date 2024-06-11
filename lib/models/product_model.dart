import 'package:image_picker/image_picker.dart';

class ProductModel {
  final String productName;
  final String category;
  final String supplier;
  final int purchasePrice;
  final int sellingPrice;
  final int minimumQuantity;
  String? description;
  dynamic productImage;
  int productQuantity;
  ProductModel(
      {required this.category,
      required this.productName,
      required this.purchasePrice,
      required this.sellingPrice,
      required this.minimumQuantity,
      required this.supplier,
      this.productImage,
      this.description,
      this.productQuantity=0,
      });
  Map<String, dynamic> toMap() {
    return {
      'supplier': supplier,
      'productName': productName,
      'category': category,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      "minimumQuantity": minimumQuantity,
      "productImage": productImage,
      "description": description,
      'productQuantity':productQuantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      supplier: data['supplier'],
      category: data["category"],
      productName: data["productName"],
      purchasePrice: data['purchasePrice'],
      sellingPrice: data['sellingPrice'],
      minimumQuantity: data['minimumQuantity'],
      productImage: data["productImage"],
      description: data['description'],
      productQuantity: data['productQuantity'],
    );
  }
}
