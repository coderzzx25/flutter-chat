import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_chat/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_chat/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_chat/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = FlutterSecureStorage();

  AuthBloc({required this.registerUseCase, required this.loginUseCase})
    : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<AppStarted>(_onAppStarted);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await registerUseCase(event.username, event.email, event.password);
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(message: 'Registration failed'));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(event.email, event.password);
      await _storage.write(key: 'token', value: user.token);
      await _storage.write(key: 'userId', value: user.id.toString());
      emit(AuthAuthenticated(token: user.token, userId: user.id));
    } catch (e) {
      emit(AuthFailure(message: 'Login failed'));
    }
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final token = await _storage.read(key: 'token');
    final userId = await _storage.read(key: 'userId');

    if (token != null && userId != null) {
      emit(AuthAuthenticated(token: token, userId: int.parse(userId)));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'userId');
    emit(AuthUnauthenticated());
  }
}
