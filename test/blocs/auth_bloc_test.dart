import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:login/blocs/auth_bloc.dart';
import 'package:login/repositories/auth_repository.dart';
import 'package:login/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';




// Mocks
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc Tests', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Authenticated] when LoginRequested is successful',
      build: () {
        // Simular éxito en la autenticación con los tipos correctos
        when(mockAuthRepository.login(any<int>(), any<String>(), any<String>()))
            .thenAnswer((_) async => UserModel(id: 123, username: 'testUser', password: 'password123'));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginRequested(username: 'testUser', password: 'password123')),
      expect: () => [
        AuthLoading(),
        Authenticated(user: UserModel(id: 123, username: 'testUser', password: 'password123'))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when LoginRequested fails',
      build: () {
        // Simular fallo en la autenticación con los tipos correctos
        when(mockAuthRepository.login(any<int>(), any<String>(), any<String>())).thenThrow(Exception('Login failed'));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginRequested(username: 'testUser', password: 'password123')),
      expect: () => [
        AuthLoading(),
        AuthError(message: "Login failed. Please try again.")
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthInitial] when LogoutRequested',
      build: () => authBloc,
      act: (bloc) => bloc.add(LogoutRequested()),
      expect: () => [AuthInitial()],
    );
  });
}
