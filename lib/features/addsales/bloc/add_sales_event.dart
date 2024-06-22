part of 'add_sales_bloc.dart';

@immutable
sealed class AddSalesEvent {}
class ConfirmSingleSale extends AddSalesEvent{
  final SelledItem selledItem;

  ConfirmSingleSale({required this.selledItem});
}

class ConfirmCompleteSales extends AddSalesEvent{
  final SalesRecordModel salesRecordModel;
  ConfirmCompleteSales({required this.salesRecordModel});
}

class DeleteButtonClickedEvent extends AddSalesEvent{
  final SelledItem selledItem;
  DeleteButtonClickedEvent({required this.selledItem});
}