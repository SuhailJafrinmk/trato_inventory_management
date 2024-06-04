part of 'add_purchase_bloc.dart';

@immutable
sealed class AddPurchaseState {}

final class AddPurchaseInitial extends AddPurchaseState {}
class SinglePurchaseAddedState extends AddPurchaseState{
  final List<PurchasedItem> purcaseItems;
  SinglePurchaseAddedState({required this.purcaseItems});
}

class PurchaseRecordAddLoading extends AddPurchaseState{}
class PurchaseRecordAddSuccess extends AddPurchaseState{}
class PurchaseRecordAddingError extends AddPurchaseState{
  final String message;

  PurchaseRecordAddingError({required this.message});

} 