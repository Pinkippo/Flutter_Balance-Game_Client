import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// 양자 택일 AWS 서버
const baseUrl = 'http://13.209.40.73:8080';

/// http 통신을 위한 클래스
class MyApiClient {

  final http.Client httpClient;
  MyApiClient({required this.httpClient});


}


