import 'package:flutter/material.dart';

/// 좋아요 여부 저장을 위한 모델
class LikeModel {

  @override
  int get hashCode => boardKey.hashCode ^ jwt.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LikeModel &&
              runtimeType == other.runtimeType &&
              boardKey == other.boardKey &&
              jwt == other.jwt;

  int? id;

  final String boardKey;
  final String jwt;

  LikeModel( {
    required this.boardKey,
    required this.jwt,
  });

  static LikeModel fromMap(Map<String, dynamic> map, String carId) {
    return LikeModel(
      boardKey: map['boardKey'] as String,
      jwt: map['jwt'] as String,
    );
  }

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      boardKey: json['boardKey'] as String,
      jwt: json['jwt'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boardKey': boardKey,
      'jwt': jwt,
    };
  }

}