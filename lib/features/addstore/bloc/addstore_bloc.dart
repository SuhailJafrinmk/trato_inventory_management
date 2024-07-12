import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:trato_inventory_management/models/store_model.dart';

part 'addstore_event.dart';
part 'addstore_state.dart';

class AddstoreBloc extends Bloc<AddstoreEvent, AddstoreState> {
  AddstoreBloc() : super(AddstoreInitial()) {
    on<AddButtonClicked>(addButtonClicked);
    on<EditButtonClicked>(editButtonClicked);
  }
  //adding a new store when a new user registering to the app
  FutureOr<void> addButtonClicked(AddButtonClicked event, Emitter<AddstoreState> emit)async {
    try{
  emit(AddstoreLoading());
   final user=FirebaseAuth.instance.currentUser;
   FirebaseFirestore firestore=FirebaseFirestore.instance;
   DocumentReference documentReference=firestore.collection('UserData').doc(user!.uid);
   CollectionReference collectionReference=documentReference.collection('store details');
    await collectionReference.doc(user.uid).set(event.storeModel.toMap());
    emit(AddstoreSuccess());
    }catch(e){
    emit(AddstoreError(errorMessage: e.toString()));
    }
  }
  
  //editing the store details provided by the user
  FutureOr<void> editButtonClicked(EditButtonClicked event, Emitter<AddstoreState> emit)async {
  try{
    emit(EditStoreLoadingState());
  final user=FirebaseAuth.instance.currentUser;
   FirebaseFirestore firestore=FirebaseFirestore.instance;
   DocumentReference documentReference=firestore.collection('UserData').doc(user!.uid).collection('store details').doc(user.uid);
   await documentReference.update(event.storeModel.toMap());
   emit(EditStoreSuccessState());
  }catch(e){
   emit(EditStoreErrorState());
  }
  }
}
