import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// STATES
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

/// CUBIT
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      emit(AuthSuccess(user.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Register error"));
    } catch (e) {
      emit(AuthError("Unknown error"));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      emit(AuthSuccess(user.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login error"));
    } catch (e) {
      emit(AuthError("Unknown error"));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(AuthInitial());
  }
}