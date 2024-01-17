import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_balance_game_client/common/pref/app_preferences.dart';
import 'package:flutter_balance_game_client/controller/login_controller.dart';
import 'package:flutter_balance_game_client/data/repository/auth_repository.dart';
import 'package:flutter_balance_game_client/route/app_pages.dart';
import 'package:flutter_balance_game_client/theme/app_thene.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// .env 파일 로드
  await dotenv.load(fileName: 'assets/config/.env');

  /// 카카오 SDK 초기화
  KakaoSdk.init(
    nativeAppKey: dotenv.env['NATIVE_APP_KEY'],
    javaScriptAppKey: dotenv.env['JV_KEY'],
  );

  /// 세로모드 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// 스플래시 생성
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// 앱 설정 파일 로드
  await AppPreferences.init();

  await initService();

  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 배너 제거
        theme: appThemeData, // 앱 테마
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
        initialRoute: Routes.initial, // 초기 라우트
      )
  );
}

/// 앱 내에서 사용할 로그인 컨트롤러 등록
Future<void> initService() async {

  /// 로그인 컨트롤러 영속성 설정
  await Get.putAsync<LoginController>(() async {
    return LoginController(authRepository: AuthRepository());
    }, permanent: true).then((value) async {
     await value.getToken();
     print("로그인 여부 : $value.isLogin");
  });
  
}