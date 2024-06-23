import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(_onLoginButtonPressed);
  }
  Future<void> _onLoginButtonPressed(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadedState());

    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.userEmail,
        password: event.userPassword,
      );
      _user = credential.user;

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool('loginkey', true);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(message: e.message ?? 'An error occurred'));
    } catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }
}
