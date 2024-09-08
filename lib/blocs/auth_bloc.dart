import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:login/repositories/auth_repository.dart';
import 'package:login/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginRequested) {
      yield AuthLoading();
      try {
        final user = await authRepository.login(event.username, event.password);
        yield Authenticated(user: user);
      } catch (e) {
        yield AuthError(message: "Login failed. Please try again.");
      }
    } else if (event is LogoutRequested) {
      yield AuthInitial();
    }
  }
}
