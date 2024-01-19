import 'package:flutter/material.dart';

/// 좋아요 여부 저장을 위한 로컬 스토리지 모델
class LikeModel {

  @override
  int get hashCode => boardKey.hashCode ^ uid.hashCode ^ timestamp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LikeModel &&
              runtimeType == other.runtimeType &&
              boardKey == other.boardKey &&
              uid == other.uid &&
              timestamp == other.timestamp;

  int? id;

  final String boardKey;
  final String uid;
  final String timestamp;

  LikeModel( {
    required this.boardKey,
    required this.uid,
    required this.timestamp,
  });

  static LikeModel fromMap(Map<String, dynamic> map, String carId) {
    return LikeModel(
      boardKey: map['boardKey'] as String,
      uid: map['uid'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      boardKey: json['boardKey'] as String,
      uid: json['uid'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boardKey': boardKey,
      'uid': uid,
      'timestamp': timestamp,
    };
  }

}