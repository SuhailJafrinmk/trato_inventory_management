import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:trato_inventory_management/models/store_model.dart';

part 'addstore_event.dart';
part 'addstore_state.dart';

class AddstoreBloc extends Bloc<AddstoreEvent, AddstoreState> {
  AddstoreBloc() : super(AddstoreInitial()) {
    on<AddButtonClicked>(addButtonClicked);
  }

  FutureOr<void> addButtonClicked(AddButtonClicked event, Emitter<AddstoreState> emit)async {
    try{
  emit(AddstoreLoading());
  final user=FirebaseAuth.instance.currentUser;
   FirebaseFirestore firestore=FirebaseFirestore.instance;
   DocumentReference documentReference=firestore.collection('UserData').doc(user!.uid);
   CollectionReference collectionReference=documentReference.collection('store details');
    await collectionReference.add(event.storeModel.toMap());
    emit(AddstoreSuccess());
    }catch(e){
    emit(AddstoreError(errorMessage: e.toString()));
    }
  }
}
