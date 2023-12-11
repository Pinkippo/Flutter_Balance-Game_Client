import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/data/model/login_reponse_model.dart';
import 'package:flutter_balance_game_client/data/model/login_request_model.dart';
import 'package:flutter_balance_game_client/data/model/register_request_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/board_response_model.dart';

/// 양자 택일 AWS 서버
const baseUrl = 'http://13.209.40.73:8080';
/// 양자 택일 스웨거 - http://13.209.40.73:8080/swagger-ui/index.html


/// http 통신을 위한 클래스
class MyApiClient {

  /// 회원가입
  Future<bool> register(RegisterRequestModel requestModel) async {
    final url = Uri.parse('$baseUrl/user/join');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestModel.toJson()),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode != 200) {
      Get.snackbar(
        '회원가입 실패',
        response.body,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    } else {
      Get.snackbar(
        '회원가입 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
  }

  /// 로그인
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    final url = Uri.parse('$baseUrl/user/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginRequestModel.toJson()),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode != 200) {
      Get.snackbar(
        '로그인 실패',
        response.body,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      throw Exception('Failed to login');
    } else {
      Get.snackbar(
        '회원가입 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      throw Exception('Failed to login');
    }
  }

  /// 메인 리스트 조회
  Future<List<BoardResponseModel>> getMainList(int pageNumber, int pageSize, String token) async {
    final url = Uri.parse('$baseUrl/board/findAllByDate?page=$pageNumber&size=$pageSize');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final List<BoardResponseModel> boardList = [];
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey('findAllBoardDtos')) {
        final List<dynamic> jsonList = jsonResponse['findAllBoardDtos'];

        for (final item in jsonList) {
          boardList.add(BoardResponseModel.fromJson(item));
        }

        return boardList;
      } else {
        Get.snackbar(
          '메인 리스트 조회 실패',
          '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        throw Exception('Failed to get main list');
      }
    } else {
      Get.snackbar(
        '메인 리스트 조회 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      throw Exception('Failed to get main list');
    }
  }
}


