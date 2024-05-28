import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:trato_inventory_management/models/user_model.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  User? user;
  RegisterBloc() : super(RegisterInitial()) {
   on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
  }

  FutureOr<void> registerButtonClickedEvent(RegisterButtonClickedEvent event, Emitter<RegisterState> emit)async {
      try {
      emit(RegisterLoadingState());
      UserCredential credential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: event.useEmail, password: event.password);
      user = credential.user;
      await firebaseAuth.currentUser!.updateDisplayName(event.useEmail);
      final currentuser = firebaseAuth.currentUser;
       UserModel model=UserModel(event.userName, event.useEmail, event.password, currentuser!.uid);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection('UserData')
          .doc(currentuser.uid)
          .set(model.toMap());
      emit(RegisterSuccessState());
    } catch (e) {
      print(e.toString());
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }
}
