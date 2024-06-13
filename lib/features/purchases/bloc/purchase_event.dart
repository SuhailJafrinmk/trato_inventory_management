part of 'purchase_bloc.dart';

@immutable
sealed class PurchaseEvent {}

//this event is called when the print button is pressed on the records tile
class PrintButtonClicked extends PurchaseEvent{
  final Map<String,dynamic>data;
  PrintButtonClicked({required this.data});
}

class DownloadButtonPressed extends PurchaseEvent{
  final Map<String,dynamic> document;

  DownloadButtonPressed({required this.document});
}