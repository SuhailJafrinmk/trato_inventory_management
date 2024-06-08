part of 'inventory_bloc.dart';

@immutable
sealed class InventoryEvent {}
class AddCategoryButtonClicked extends InventoryEvent{
CategoryModel categoryModel;
AddCategoryButtonClicked(this.categoryModel);  
}
class CategoryTileLongpress extends InventoryEvent{
  final String categoryName;

CategoryTileLongpress({required this.categoryName});

}
class FetchCategoriesEvent extends InventoryEvent{}
class DeleteConfirmationClicked extends InventoryEvent{
  Map<String,dynamic>?document;
  DeleteConfirmationClicked({required this.document});
}

class AddPurchaseButtonClicked extends InventoryEvent{
final PurchaseRecord purchaseRecord;
  AddPurchaseButtonClicked({required this.purchaseRecord});
}

class CategoryTileClicked extends InventoryEvent{
  final String categoryName;

  CategoryTileClicked({required this.categoryName});
}