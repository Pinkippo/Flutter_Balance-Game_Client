import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// 게시글 상세 관련 Getx Controller
class BoardDetailController extends GetxController{

  final storage = const FlutterSecureStorage();

  /// TODO : 상세 페이지 내부 기능 구현

  // 게시물 정보 호출
  Future<void> getBoardDetail() async {
    print("게시물 정보 호출");
    try {
      final Map<String, dynamic> parameters = Get.parameters;
      int boardKey = int.parse(parameters['boardKey'] ?? '');
      print("게시물 번호 : $boardKey");

      /// TODO : 게시물 호출 API 연동

    } catch (error) {
      print(error);
    }
  }


}