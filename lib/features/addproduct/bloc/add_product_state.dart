part of 'add_product_bloc.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}
class CategorySelectedState extends AddProductState{
 final String? newValue;
  CategorySelectedState({required this.newValue});
}
class FetchingFailedState extends AddProductState{
  final String message;

  FetchingFailedState({required this.message});
}
class FetchingSuccessState extends AddProductState{
  final List<String> dropDownItems;

  FetchingSuccessState({required this.dropDownItems});
}
class CategoryLoadingState extends AddProductState{}

class AddImageSuccessState extends AddProductState{}
class AddImageLoadingState extends AddProductState{}
class AddImageErrorState extends AddProductState{
  final String message;

  AddImageErrorState({required this.message});
}
class ImagePickedState extends AddProductState{
  File? croppedIage;
  ImagePickedState({required this.croppedIage});
}
class ProductAddedSuccessState extends AddProductState{}
class AddProductErrorState extends AddProductState{
  final String message;

  AddProductErrorState({required this.message});
}
class AddProductLoadingState extends AddProductState{}


//for fetching the available products 
class FetchProductsLoading extends AddProductState{}
class FetchProductsSuccess extends AddProductState{
  final List<String> products;
  FetchProductsSuccess({required this.products});
}
class FetchProductsFailed extends AddProductState{}



//for editing the product
class EditProductLoadingState extends AddProductState{}
class EditProductSuccessState extends AddProductState{}
class EditProductErrorState extends AddProductState{
  final String message;
  EditProductErrorState({required this.message});
}