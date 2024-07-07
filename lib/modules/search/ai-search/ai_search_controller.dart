import 'package:get/get.dart';

enum AiQuickSearchType {
  food('음식물이 묻은 비닐은 어떻게 버려야해?', "Clam"),
  tape('카세트 테이프 배출법 알려줘', 'Tape'),
  bowl('도자기는 어떻게 버려?', 'Bowl'),
  bigTrash('우리 동네 대형폐기물 수거 업체 알려줘', 'Taxi');

  final String value;
  final String iconUrl;

  const AiQuickSearchType(this.value, this.iconUrl);
}

enum AiQuickChip {
  trash('오늘의 배출 쓰레기', "trash"),
  link('동대문구청 바로가기', 'Link');

  final String value;
  final String iconUrl;

  const AiQuickChip(this.value, this.iconUrl);
}

class AiSearchController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
}
