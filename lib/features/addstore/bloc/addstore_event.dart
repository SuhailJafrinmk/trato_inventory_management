part of 'addstore_bloc.dart';

@immutable
sealed class AddstoreEvent {}
class AddButtonClicked extends AddstoreEvent{
  final StoreModel storeModel;

  AddButtonClicked({required this.storeModel});


}
