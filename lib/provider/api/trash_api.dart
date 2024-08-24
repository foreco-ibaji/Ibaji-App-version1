import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ibaji/model/detail_method/detail_method.dart';
import 'package:ibaji/provider/api/util/dio_services.dart';
import 'package:logger/logger.dart';
import '../../model/trash/trash.dart';

class TrashRepository {
  ///세부 품목 조회
  ///* recycle_detail_view
  static Future<DetailMethod> getDetailMethod({
    required int id,
  }) async {
    try {
      // 다른 필요한 데이터가 있다면 추가
      Response response =
          await DioServices().to().get("/trash/detail", queryParameters: {
        'id': id,
      });

      Logger().d(response.data['data']);

      return DetailMethod.fromJson(response.data['data']);
    } catch (e) {
      Logger().d(e.toString());
      throw e.toString();
    }
  }

  ///세부 품목 조회 하단 관련 쓰레기 리스트
  ///* recycle_detail_view
  static Future<List<Trash>> getRelationTrash({
    required int id,
  }) async {
    try {
      // 다른 필요한 데이터가 있다면 추가
      Response response = await Dio()
          .get(dotenv.env['apiUrl']! + "/trash/relation", queryParameters: {
        'id': id,
      });

      Logger().d(response.data['data']);

      return List.generate(
        response.data['data']['recommendTrashes'].length,
        (index) {
          return Trash.fromJson(
            response.data['data']['recommendTrashes'][index],
          );
        },
      );
    } catch (e) {
      Logger().d(e.toString());
      throw e.toString();
    }
  }
}
