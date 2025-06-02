// lib/features/auth/data/models/user_model.dart
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart'; // généré par json_serializable

@JsonSerializable()
class UserModel {
  final String accessToken;

  // final String refreshToken;

  final String tokenType;

  final int expiresIn;

  final String username;

  final List<String> roles;

  UserModel({
    required this.accessToken,
    // required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.username,
    required this.roles,
  });

  // === JSON (de)serialization ===
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // === Mapping vers ton entité domaine ===
  User toEntity() => User(
    username: username,
    accessToken: accessToken,
    // refreshToken: refreshToken,
    tokenType: tokenType,
    expiresIn: expiresIn,
    roles: roles,
  );
}
