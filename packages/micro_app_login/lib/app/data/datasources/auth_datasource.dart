import '../../domain/entities/auth_response.dart';

abstract class AuthDatasource {
  Future<AuthResponse> loginWithGoogle();
  Future<AuthResponse> loginWithApple();
  Future<AuthResponse> loginWithEmailAndPassword(String email, String password);
  Future<void> logout();
  Future<void> sendEmailVerification(String email, String password);
}
