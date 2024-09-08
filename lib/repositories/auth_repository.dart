import 'package:login/models/user_model.dart';

class AuthRepository {
  Future<UserModel> login(int id,String username, String password) async {
    // Aquí iría la lógica para autenticar al usuario, por ejemplo, a través de una API.
    // Retorna un UserModel si las credenciales son válidas.
    if (username == 'user' && password == 'password') {
      return UserModel(id:id,username: username,password: password);
    } else {
      throw Exception('Login failed');
    }
  }
}
