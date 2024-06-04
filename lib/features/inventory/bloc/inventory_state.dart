part of 'inventory_bloc.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {}
class CategoryAddedSuccess extends InventoryState{}
class CategoryAddedError extends InventoryState{
  final String errorMessage;

  CategoryAddedError({required this.errorMessage});
}
class CategoryAddLoading extends InventoryState{}
class CategoryDeleted extends InventoryState{}
class CategoryDeletionError extends InventoryState{}
class CategoriesFetchedState extends InventoryState{
   List<String> ?documentList;
   CategoriesFetchedState(this.documentList);
}
class ProductDeletingLoadingState extends InventoryState{}
class ProductDeletedSuccessState extends InventoryState{}
class ProductDeletingErrorState extends InventoryState{}
