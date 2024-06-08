part of 'purchase_bloc.dart';

@immutable
sealed class PurchaseEvent {}
class PrintButtonClicked extends PurchaseEvent{
  final Map<String,dynamic>data;
  PrintButtonClicked({required this.data});
}

class DownloadButtonPressed extends PurchaseEvent{
  final Map<String,dynamic> document;

  DownloadButtonPressed({required this.document});
}