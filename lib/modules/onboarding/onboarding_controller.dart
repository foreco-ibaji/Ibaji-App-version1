import 'package:get/get.dart';

class OnboardingController extends GetxController {}

enum ResidentType {
  single(
      fieldName: "single",
      title: "단독 주택",
      subtitle: "건물 소유자가 1명인 다가구주택, 기숙사 및 고시원 등 다중주택",
      imgUrl: "ic_home_86.png"),
  multiple(
      fieldName: "multiple",
      title: "공동 주택",
      subtitle: "세대 별 소유자가 다른 다세대 주택, 연립주택, 아파트와 오피스텔 등",
      imgUrl: "ic_home_together_78.png");

  final String fieldName;
  final String title;
  final String subtitle;
  final String imgUrl;

  const ResidentType(
      {required this.fieldName,
      required this.title,
      required this.subtitle,
      required this.imgUrl});
}
