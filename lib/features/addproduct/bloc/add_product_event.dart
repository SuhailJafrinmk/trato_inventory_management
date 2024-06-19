part of 'add_product_bloc.dart';

@immutable
sealed class AddProductEvent {}
class DropdownTextfieldClicked extends AddProductEvent{
  String ?selectedItem;
  DropdownTextfieldClicked({this.selectedItem});
}
class FetchCategoriesEvent extends AddProductEvent{}
class AddProductButtonClicked extends AddProductEvent{
  final ProductModel productModel;

  AddProductButtonClicked({required this.productModel});
}

class AddImageButtonClicked extends AddProductEvent{}
class FetchProducts extends AddProductEvent{}
class EditProductClicked extends AddProductEvent{
  final ProductModel productModel;
  String? oldDoc;
  EditProductClicked({required this.productModel,this.oldDoc});
}