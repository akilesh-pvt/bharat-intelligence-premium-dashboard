import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/models/admin.dart';

// Events
abstract class AuthEvent {}

class CheckAuthStatus extends AuthEvent {}
class SignInWithGoogle extends AuthEvent {}
class SignOut extends AuthEvent {}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Admin admin;
  AuthAuthenticated(this.admin);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final admin = await _authService.getCurrentUser();
      if (admin != null) {
        emit(AuthAuthenticated(admin));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError('Failed to check authentication status: $e'));
    }
  }

  Future<void> _onSignInWithGoogle(SignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final admin = await _authService.signInWithGoogle();
      if (admin != null) {
        emit(AuthAuthenticated(admin));
      } else {
        emit(AuthError('Sign in was cancelled'));
      }
    } catch (e) {
      emit(AuthError('Sign in failed: $e'));
    }
  }

  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    try {
      await _authService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Sign out failed: $e'));
    }
  }
}