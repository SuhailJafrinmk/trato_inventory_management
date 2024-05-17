class ProductModel{
  final String productImage;
  final String productName;
  final int purchasePrice;
  final int sellingPrice;
  final int minimumQuantity;
  String ? description;
  ProductModel({required this.productName, required this.purchasePrice, required this.sellingPrice, required this.minimumQuantity,required this.productImage,this.description});
}