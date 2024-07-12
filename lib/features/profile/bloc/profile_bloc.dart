import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final firestore=FirebaseFirestore.instance;
  ProfileBloc() : super(ProfileInitial()) {
   on<LogoutTilePressed>(logoutTilePressed);
   on<FetchStoreDetails>(fetchStoreDetails);
  }

  FutureOr<void> logoutTilePressed(LogoutTilePressed event, Emitter<ProfileState> emit)async {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    try{
      emit(LogoutLoading());
      await firebaseAuth.signOut();
      sharedPreferences.setBool('loginkey',false);
      emit(LogoutSuccess());
    }catch(e){
      emit(LogoutError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> fetchStoreDetails(FetchStoreDetails event, Emitter<ProfileState> emit) async{
    try{
    emit(FetchingStoreDetails());
     final user = FirebaseAuth.instance.currentUser?.uid;
      if (user == null) {
        throw Exception("User not logged in");
      }
    DocumentReference documentReference=firestore.collection('UserData').doc(user).collection('store details').doc(user);
    final documents=await documentReference.get();
    final data=documents.data() as Map<String,dynamic>;
    emit(FetchedStoreDetails(data: data));
    }catch(e){
      emit(FetchingStoreDetailsFailed(message: e.toString()));
    }
  }
}
