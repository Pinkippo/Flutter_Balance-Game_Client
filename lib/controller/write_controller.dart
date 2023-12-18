import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 글쓰기 입력 정보 Getx Controller
class WriteController extends GetxController{

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    /// 글쓰기 입력 정보
    final TextEditingController writeTitle = TextEditingController(); // 제목
    final TextEditingController writeLeft = TextEditingController(); // 왼쪽
    final TextEditingController writeRight = TextEditingController(); // 오른쪽

    /// 글쓰기 입력 정보 초기화
    void clearWriteInput() {
        writeTitle.clear();
        writeLeft.clear();
        writeRight.clear();
    }

    /// 글쓰기 입력 정보 유효성 검사
    String? validateInput(String value) {
        if (value.isEmpty) {
            return '내용을 입력해주세요!';
        }
        return null;
    }

}