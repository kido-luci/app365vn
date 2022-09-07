// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laptt_app365vn/configs/path.dart';
import 'package:laptt_app365vn/models/area_code_model/area_code_model.dart';

class AreaCodeService {
  static List<AreaCodeModel> getAreaCodeList(List<dynamic> jsonData) {
    final List<AreaCodeModel> areaCodeList = List.empty(growable: true);
    for (var element in jsonData) {
      areaCodeList.add(AreaCodeModel.fromJson(element));
    }
    return areaCodeList;
  }

  static Future<List<AreaCodeModel>> fetchAreaCodeList(
      {String keyWork = '', required int soDongDaHienThi}) async {
    Map<String, String> parameters = {
      'soDongDaHienThi': soDongDaHienThi.toString()
    };
    if (keyWork.isNotEmpty) {
      parameters.addAll({'tuKhoa': keyWork});
    }
    final response = await http.get(
      Uri.http(API_SERVER_PATH, AREA_CODE_API, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getAreaCodeList(jsonDecode(response.body)['data']['maVungs']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot get area code list');
    }
  }
}
