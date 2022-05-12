import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResponse {
  final String? name;
  final String? email;
  final bool? isEmailVerified;
  final String? photoUrl;
  final String? token;
  final String? refreshToken;

  AuthResponse({
    this.name,
    this.email,
    this.isEmailVerified,
    this.photoUrl,
    this.token,
    this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'photoUrl': photoUrl,
      'token': token,
      'refreshToken': refreshToken,
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      name: map['name'],
      email: map['email'],
      isEmailVerified: map['isEmailVerified'],
      photoUrl: map['photoUrl'],
      token: map['token'],
      refreshToken: map['refreshToken'],
    );
  }

  Future<AuthResponse> fromCredential(UserCredential credential) async {
    final token = await credential.user?.getIdToken();
    final refreshToken = credential.user?.refreshToken;
    return AuthResponse(
      name: credential.user?.displayName,
      email: credential.user?.email,
      isEmailVerified: credential.user?.emailVerified,
      photoUrl: credential.user?.photoURL,
      token: token,
      refreshToken: refreshToken,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));
}
