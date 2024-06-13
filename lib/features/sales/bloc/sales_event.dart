part of 'sales_bloc.dart';

@immutable
sealed class SalesEvent {}

//the event is called when the print button is clicked on the listtile of sales records
class PrintSalesButtonClicked extends SalesEvent{
  final Map<String,dynamic> data;

  PrintSalesButtonClicked({required this.data});

}
