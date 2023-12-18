import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// 글쓰기 입력 정보 Getx Controller
class WriteController extends GetxController{

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


}