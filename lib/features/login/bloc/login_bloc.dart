import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  User ?user;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  LoginBloc() : super(LoginInitial()) {
 on<LoginButtonPressedEvent>(loginButtonPressedEvent);
  }

  FutureOr<void> loginButtonPressedEvent(LoginButtonPressedEvent event, Emitter<LoginState> emit) async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        try {
      emit(LoginLoadedState());
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
      email: event.userEmail,
      password: event.userPassword,
      );
      user = credential.user;
      print('logged in success');
      emit(LoginSuccessState());
      sharedPreferences.setBool('loginkey', true);
    } on FirebaseAuthException catch(e){
      print(e);
       emit(LoginErrorState(message: '$e.user not found'));
    }
    catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }
}
