import 'package:flutter/material.dart';

/// 커스텀 Radius 이미지 위젯
class CustomRadiusImage extends StatelessWidget {
  final double radius;
  final double width;
  final double height;
  final Image image;
  final Color backgroundColor;

  const CustomRadiusImage(
      {required this.radius,
      required this.width,
      required this.height,
      required this.image,
      this.backgroundColor = Colors.white,
      super.key});

  /// 네트워크 이미지
  CustomRadiusImage.network(
    String src, {
    required this.radius,
    BoxFit boxFit = BoxFit.cover,
    required this.width,
    required this.height,
    this.backgroundColor = Colors.white,
    super.key,
  }) : image = Image.network(src, fit: boxFit);

  /// 파일 이미지
  CustomRadiusImage.asset({
    required String fileDirectory,
    required String fileName,
    required this.radius,
    BoxFit boxFit = BoxFit.cover,
    required this.width,
    required this.height,
    this.backgroundColor = Colors.white,
    super.key,
  }) : image = Image.asset(
          "assets/images/$fileDirectory/$fileName.png",
          fit: boxFit,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child:
          ClipRRect(borderRadius: BorderRadius.circular(radius), child: image),
    );
  }
}
