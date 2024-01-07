import 'package:flutter/material.dart';

/// 게임 참여 여부 저장을 위한 로컬 스토리지 모델
class GameModel {

  @override
  int get hashCode => boardKey.hashCode ^ result.hashCode ^ jwt.hashCode ^ timestamp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GameModel &&
              runtimeType == other.runtimeType &&
              boardKey == other.boardKey &&
              result == other.result &&
              jwt == other.jwt &&
              timestamp == other.timestamp;

  int? id;

  final String boardKey;
  final String result;
  final String jwt;
  final String timestamp;

  GameModel( {
    required this.boardKey,
    required this.result,
    required this.jwt,
    required this.timestamp,
  });

  static GameModel fromMap(Map<String, dynamic> map, String carId) {
    return GameModel(
      boardKey: map['boardKey'] as String,
      result: map['result'] as String,
      jwt: map['jwt'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      boardKey: json['boardKey'] as String,
      result: json['result'] as String,
      jwt: json['jwt'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boardKey': boardKey,
      'result': result,
      'jwt': jwt,
      'timestamp': timestamp,
    };
  }

}