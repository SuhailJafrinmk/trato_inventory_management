part of 'add_purchase_bloc.dart';

@immutable
sealed class AddPurchaseEvent {}
class ConfirmQuantity extends AddPurchaseEvent{
  PurchasedItem purchasedItem;
  ConfirmQuantity({required this.purchasedItem});
}
class AddRecordConfirm extends AddPurchaseEvent{
  final PurchaseRecord record;

  AddRecordConfirm({required this.record});
}