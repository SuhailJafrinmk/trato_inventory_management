import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
   on<LogoutTilePressed>(logoutTilePressed);
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
}
