import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/common/app_colors.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_balance_game_client/data/model/login_reponse_model.dart';
import 'package:flutter_balance_game_client/data/model/login_request_model.dart';
import 'package:flutter_balance_game_client/data/model/register_request_model.dart';
import 'package:flutter_balance_game_client/data/model/user_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/board_response_model.dart';

/// 양자 택일 AWS 서버
const baseUrl = 'http://3.36.88.115:8080';

/// 양자 택일 스웨거 - http://3.36.88.115:8080/swagger-ui/index.html

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
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
      );
      return false;
    } else {
      Get.snackbar(
        '회원가입 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
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
      return LoginResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else if (response.statusCode != 200) {
      Get.snackbar(
        '아이디 혹은 비밀번호가 일치하지 않습니다.',
        '다시 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to login');
    } else {
      Get.snackbar(
        '로그인 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to login');
    }
  }

  /// 회원 탈퇴
  Future<bool> secession(String token, String password) async {
    final url = Uri.parse('$baseUrl/user/delete');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'pw': password,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      return true;
    }else if(response.statusCode == 500){
      return false;
    }else{
      return false;
    }
  }

  /// 회원 정보 조회
  Future<UserResponseModel> getUserInfo(String token) async {
    final url = Uri.parse('$baseUrl/user/profile');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return UserResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else if(response.statusCode == 403){
      return UserResponseModel(
        userId: '',
        userName: '',
        message: LoginState.loginExpired,
        userEmail: '',
      );
    } else{
      return UserResponseModel(
        userId: '',
        userName: '',
        message: LoginState.logout,
        userEmail: '',
      );
    }
  }

  /// 메인 리스트 조회
  Future<List<BoardResponseModel>> getMainList(
      int pageNumber, int pageSize, String token) async {
    final url = Uri.parse(
        '$baseUrl/board/findAllByDate?page=$pageNumber&size=$pageSize');

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
      final Map<String, dynamic> jsonResponse =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (jsonResponse.containsKey('findAllBoardDtos')) {
        if (jsonResponse['findAllBoardDtos'] == null) {
          return boardList;
        }

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
          backgroundColor: AppColors.mainRedColor,
          colorText: Colors.white,
        );
        throw Exception('Failed to get main list');
      }
    } else {
      Get.snackbar(
        '메인 리스트 조회 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to get main list');
    }
  }

  /// 좋아요 순 메인 리스트 조회
  Future<List<BoardResponseModel>> getMainListByHeart(
      int pageNumber, int pageSize, String token) async {
    final url = Uri.parse(
        '$baseUrl/board/findAllByHeart?page=$pageNumber&size=$pageSize');

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
      final Map<String, dynamic> jsonResponse =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (jsonResponse.containsKey('findAllBoardDtos')) {
        if (jsonResponse['findAllBoardDtos'] == null) {
          return boardList;
        }

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
          backgroundColor: AppColors.mainRedColor,
          colorText: Colors.white,
        );
        throw Exception('Failed to get main list');
      }
    } else {
      Get.snackbar(
        '메인 리스트 조회 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to get main list');
    }
  }

  /// 내가 좋아요 누른 글 메인 리스트 조회
  Future<List<BoardResponseModel>> getMainListByHeartOn(
      int pageNumber, int pageSize, String token) async {
    final url = Uri.parse(
        '$baseUrl/board/findAllByUserHeart?page=$pageNumber&size=$pageSize');

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
      final Map<String, dynamic> jsonResponse =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (jsonResponse.containsKey('findAllBoardDtos')) {
        // 값이 없을 때 빈 리스트를 반환하도록 수정
        if (jsonResponse['findAllBoardDtos'] == null) {
          return boardList;
        }

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
          backgroundColor: AppColors.mainRedColor,
          colorText: Colors.white,
        );
        throw Exception('Failed to get main list');
      }
    } else {
      Get.snackbar(
        '메인 리스트 조회 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to get main list');
    }
  }

  /// 글쓰기
  Future<bool> write(
      String token, String title, String left, String right) async {
    final url = Uri.parse('$baseUrl/board/regist');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'boardTitle': title,
        'leftContent': left,
        'rightContent': right,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      Get.snackbar(
        '글쓰기 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:  AppColors.mainRedColor,
        colorText: Colors.white,
      );
      return false;
    }
  }

  /// 게시글 상세 조회
  Future<BoardResponseModel> getBoardDetail(String token, int boardKey) async {
    final url = Uri.parse('$baseUrl/board/detail?boardKey=$boardKey');

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
      final Map<String, dynamic> jsonResponse =
          jsonDecode(utf8.decode(response.bodyBytes));
      return BoardResponseModel.fromJson(jsonResponse);
    } else {
      /// 오류 발생 시 -1번의 키를 가진 빈 모델을 반환
      return BoardResponseModel(
        boardKey: -1,
        userName: '',
        boardDate: '',
        boardTitle: '',
        leftContent: '',
        rightContent: '',
        heartCount: 0,
        leftCount: 0,
        rightCount: 0,
        commentList: [],
      );
    }
  }

  /// 댓글 작성
  Future<int> writeComment(
      String token, int boardKey, String content) async {
    final url = Uri.parse('$baseUrl/comment/regist');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'boardKey': boardKey,
        'commentContent': content,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      Get.snackbar(
        '댓글 작성 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
      );
      return 0;
    }
  }

  /// 좋아요 추가
  Future<bool> addLike(String token, int boardKey) async {
    final url = Uri.parse('$baseUrl/boardHeartHistory/insert');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'boardKey': boardKey,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      Get.snackbar(
        '좋아요 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
      );
      return false;
    }
  }

  /// 좋아요 삭제
  Future<bool> deleteLike(String token, int boardKey) async {
    final url = Uri.parse('$baseUrl/boardHeartHistory/delete');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'boardKey': boardKey,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      Get.snackbar(
        '좋아요 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
      );
      return false;
    }
  }

  /// 댓글 삭제
  Future<bool> deleteComment(String token, int boardKey ,int commentKey) async {
    final url = Uri.parse('$baseUrl/comment/delete');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'boardKey' : boardKey,
        'commentKey': commentKey,
      }),
    );
    print("댓글삭제 상태 : ${response.statusCode}");

    if (response.statusCode == 200) {
      return true;
    } else if(response.statusCode == 500){
      Get.snackbar(
        '댓글 삭제 실패',
        '본인이 작성한 댓글이 아닙니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 60, left: 10, right: 10)
      );
      return false;
    } else {
      Get.snackbar(
        '댓글 삭제 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainRedColor,
        colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 60, left: 10, right: 10)
      );
      return false;
    }
  }

  /// 게임 참여
  Future<bool> addGame(String token, int boardKey, String result) async {
    final url = Uri.parse('$baseUrl/boardGame/start');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'boardKey': boardKey,
        'result': result,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// 게시물 신고
  Future<bool> reportBoard(String token, int boardKey, String reason) async {
    final url = Uri.parse('$baseUrl/board/report');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'boardKey': boardKey,
        'reportTitle' : '게시물 신고합니다',
        'reportContent': reason,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// 댓글 신고
  Future<bool> reportComment(String token, int commentKey, String reason) async {
    final url = Uri.parse('$baseUrl/comment/report');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'commentKey': commentKey,
        'reportTitle' : '댓글 신고합니다',
        'reportContent': reason,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}
