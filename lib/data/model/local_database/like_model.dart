import 'package:flutter/material.dart';

/// 좋아요 여부 저장을 위한 로컬 스토리지 모델
/// TODO : jwt를 Uid로 변경해서 사용해야함
class LikeModel {

  @override
  int get hashCode => boardKey.hashCode ^ jwt.hashCode ^ timestamp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LikeModel &&
              runtimeType == other.runtimeType &&
              boardKey == other.boardKey &&
              jwt == other.jwt &&
              timestamp == other.timestamp;

  int? id;

  final String boardKey;
  final String jwt;
  final String timestamp;

  LikeModel( {
    required this.boardKey,
    required this.jwt,
    required this.timestamp,
  });

  static LikeModel fromMap(Map<String, dynamic> map, String carId) {
    return LikeModel(
      boardKey: map['boardKey'] as String,
      jwt: map['jwt'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      boardKey: json['boardKey'] as String,
      jwt: json['jwt'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boardKey': boardKey,
      'jwt': jwt,
      'timestamp': timestamp,
    };
  }

}