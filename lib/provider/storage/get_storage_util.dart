import 'dart:async';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:ibaji/model/search_detail/search_detail.dart';

enum StorageKey {
  JWT_TOKEN,
  REFRESH_TOKEN,
  LATEST_SEARCH,
}

class GetStorageUtil {
  ///* singleton 내부 저장소
  static final storage = GetStorage();

  //GetStorage에서 key에 해당하는 value를 가져옴
  ///* return : String
  static Future<String?> getToken(StorageKey key) async {
    final String? token = storage.read(key.name);
    if (token == null) {
      return null;
    }
    return token;
  }

  ///* return : String
  static Future<void> setToken(StorageKey key, String token) async {
    await storage.write(key.name, token);
  }

  ///* return : String
  static Future<void> removeToken(StorageKey key) async {
    await storage.remove(key.name);
  }

  ///GetStorage에서 key에 해당하는 value를 설정해줌

  ///GetStorage에서 key에 해당하는 value를 제거
  ///* [key] : [StorageKey] enum
  static Future<void> delAllSearch(StorageKey key) async =>
      await storage.remove(key.name);

  ///GetStorage에서 최근 검색 목록 설정
  static Future<void> setLatestSearches(List<SearchDetail> searches) async {
    List<Map<String, dynamic>> input = searches.map((e) => e.toJson()).toList();

    await storage.write(StorageKey.LATEST_SEARCH.name, jsonEncode(input));
  }

  ///GetStorage에서 최근 검색 목록 조회
  static Future<List<SearchDetail>> getLatestSearches() async {
    String? data = storage.read(StorageKey.LATEST_SEARCH.name);

    if (data == null) {
      return List.empty();
    }

    List<dynamic> jsons = jsonDecode(data);

    return jsons.map((json) => SearchDetail.fromJson(json)).toList();
  }

  ///GetStorage에서 최근 검색 목록 전체 삭제
  static Future<void> delAllLatestSearches() async {
    await storage.remove(StorageKey.LATEST_SEARCH.name);
  }
}
