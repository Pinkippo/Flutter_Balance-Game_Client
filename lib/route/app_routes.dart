part of 'app_pages.dart';

/// 앱 내 페이지 경로 설정 클래스
abstract class Routes{

  Routes._(); // 생성자 private

  /// 페이지 경로
  static const initial = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const main = '/main';
  static const detail = '/detail';
  static const secession = '/secession';
}