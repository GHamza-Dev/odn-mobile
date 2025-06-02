// lib/features/auth/domain/entities/user.dart
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String accessToken;
  // final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final String username;
  final List<String> roles;

  const User({
    required this.accessToken,
    // required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.username,
    required this.roles,
  });

  /// copyWith pour modifications partielles si besoin
  User copyWith({
    String? accessToken,
    String? refreshToken,
    String? tokenType,
    int? expiresIn,
    String? username,
    List<String>? roles,
  }) {
    return User(
      accessToken: accessToken ?? this.accessToken,
      // refreshToken: refreshToken ?? this.refreshToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      username: username ?? this.username,
      roles: roles ?? this.roles,
    );
  }

  @override
  List<Object?> get props => [
    accessToken,
    // refreshToken,
    tokenType,
    expiresIn,
    username,
    roles,
  ];
}
