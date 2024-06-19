part of 'addstore_bloc.dart';

@immutable
sealed class AddstoreState {}

final class AddstoreInitial extends AddstoreState {}
class AddstoreSuccess extends AddstoreState{}
class AddstoreError extends AddstoreState{
  final String errorMessage;

  AddstoreError({required this.errorMessage});

}
class AddstoreLoading extends AddstoreState{}

class EditStoreLoadingState extends AddstoreState{}
class EditStoreErrorState extends AddstoreState{}
class EditStoreSuccessState extends AddstoreState{}