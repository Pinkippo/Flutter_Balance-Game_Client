import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';

/// 공유할 데이터 모델
class ShareModel {
  String title;
  String url;
  String likeCount;
  String commentCount;
  String boardKey;

  ShareModel({
    required this.title,
    required this.url,
    required this.likeCount,
    required this.commentCount,
    required this.boardKey,
  });
}

/// 카카오 공유하기
class KakaoShareManager {

  /// 카카오톡 공유하기
  void shareMyCode(ShareModel shareModel) async {

    // 카카오톡 설치 여부 확인
    bool isKakaoTalkSharingAvailable = await isKakaoTalkInstalled();
    // 탬플릿 생성
    var template =  _getTemplateV2(shareModel);
    // 설치 여부에 따른 로직 분기
    if (isKakaoTalkSharingAvailable) {
      Uri uri = await ShareClient.instance.shareDefault(template: template);
      await ShareClient.instance.launchKakaoTalk(uri);
    }else{
      Uri shareUrl = await WebSharerClient.instance.makeDefaultUrl(template: template);
      await launchBrowserTab(shareUrl, popupOpen: false);
    }
  }

  /// 탬플릿 제작
  DefaultTemplate _getTemplateV2(ShareModel shareModel){

    String title = shareModel.title;
    String url = shareModel.url;
    String likeCount = shareModel.likeCount;
    String commentCount = shareModel.commentCount;
    String boardKey = shareModel.boardKey;

    final FeedTemplate template = FeedTemplate(
      content: Content(
        title: title,
        description: "양자택일을 통해 친구와 나의 의견을 확인해보세요!",
        imageUrl: Uri.parse("https://k.kakaocdn.net/14/dn/btsDCNVOr8S/s1lQ3XekZo5TLImV09v1Vk/o.jpg"),
        link: Link(
            mobileWebUrl: Uri.parse(url)),
      ),
      social: Social(
        likeCount: int.parse(likeCount),
        commentCount: int.parse(commentCount),
      ),
      buttons: [
        Button(
          title: '앱으로보기',
          link: Link(
            mobileWebUrl: Uri.parse(url),
            androidExecutionParams: {'boardKey': boardKey},
            iosExecutionParams: {'boardKey': boardKey},
          ),
        ),
      ],
    );

    return template;

  }

}