// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
// import 'package:trato_inventory_management/models/user_model.dart';
// part 'register_event.dart';
// part 'register_state.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   FirebaseAuth firebaseAuth=FirebaseAuth.instance;
//   User? user;
//   RegisterBloc() : super(RegisterInitial()) {
//    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
//   }

//   FutureOr<void> registerButtonClickedEvent(RegisterButtonClickedEvent event, Emitter<RegisterState> emit)async {
//       try {
//       emit(RegisterLoadingState());
//       UserCredential credential =await firebaseAuth.createUserWithEmailAndPassword(email: event.useEmail, password: event.password);
//       user = credential.user;
//       await firebaseAuth.currentUser!.updateDisplayName(event.useEmail);
//       final currentuser = firebaseAuth.currentUser;
//        UserModel model=UserModel(event.userName, event.useEmail, event.password, currentuser!.uid);
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//       await firestore
//           .collection('UserData')
//           .doc(currentuser.uid)
//           .set(model.toMap());
//       emit(RegisterSuccessState());
//     } catch (e) {
//       print(e.toString());
//       emit(RegisterErrorState(errorMessage: e.toString()));
//     }
//   }
// }
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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
  }

  //this function registers a new user with an email and password and store username and useremail to firestore
  FutureOr<void> registerButtonClickedEvent(RegisterButtonClickedEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(RegisterLoadingState());
      // Register the user with Firebase Authentication
      UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: event.useEmail,
        password: event.password,
      );
      user = credential.user;
      // Update the user's display name
      await firebaseAuth.currentUser!.updateDisplayName(event.userName);
      // Ensure the user is properly reloaded
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        await currentUser.reload();
        await currentUser.updateDisplayName(event.userName);
      }
      UserModel model=UserModel(userName: event.userName, userEmail: event.useEmail,uid: currentUser!.uid);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('UserData').doc(currentUser.uid).set(model.toMap());
      emit(RegisterSuccessState());
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'The email address is already in use by another account.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'operation-not-allowed':
            errorMessage = 'Email/password accounts are not enabled.';
            break;
          case 'weak-password':
            errorMessage = 'The password is too weak.';
            break;
          default:
            errorMessage = 'An unknown error occurred.';
        }
      } else {
        errorMessage = 'An unknown error occurred: ${e.toString()}';
      }
      emit(RegisterErrorState(errorMessage: errorMessage));
    }
  }
}
