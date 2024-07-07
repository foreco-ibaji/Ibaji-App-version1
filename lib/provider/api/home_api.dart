import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ibaji/provider/api/util/dio_services.dart';
import 'package:ibaji/provider/api/util/secret_key.dart';
import 'package:logger/logger.dart';

import '../../model/trash/trash.dart';

class HomeRepository {
  ///배출요일 조회
  ///* home_view
  static Future<List<String>> getCalendar(
    String day,
  ) async {
    try {
      Response response = await Dio()
          .get(dotenv.env['apiUrl']! + "/disposal", queryParameters: {
        'day': day,
      });
      Logger().d(response.data);

      return List<String>.from(response.data['data']['categoryNames']);
    } catch (e) {
      Logger().d(e.toString());
      throw e.toString();
    }
  }

  ///검색
  ///* home_view
  static Future<List<Trash>> getSearch(
    String keyword,
  ) async {
    try {
      Response response =
          await DioServices().to().get("/trash", queryParameters: {
        'keyword': keyword,
      });
      Logger().d(response.data);

      return List.generate(
        response.data['data']['trashes'].length,
        (index) {
          return Trash.fromJson(
            response.data['data']['trashes'][index],
          );
        },
      );
    } catch (e) {
      Logger().d(e.toString());
      throw e.toString();
    }
  }
}
