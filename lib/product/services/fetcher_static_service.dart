import 'dart:convert';
import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:misyonbank/product/config/network.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/models/project/project_filter_model.dart';

class FetcherStaticService {
  static testRequest() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({});
    var dio = Dio();
    var response = await dio.request(
      '$baseURL/projectdbit/getfilteredprojects',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      List data = response.data['data'];
      print(data);
    } else {
      print(response.statusMessage);
    }
  }

  // API'den veri çekme
  static Future<List<ProjectModel>> fetchFilteredProjects(
      {ProjectFilterModel? requestModel}) async {
    const String url = '$baseURL/projectdbit/getfilteredprojects';
    final Dio dioObj = Get.find();
    var data = requestModel != null ? requestModel.toJson() : json.encode({});
    try {
      var response = await dioObj.post(
        url,
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data['data']; // API verisi
        if (kDebugMode) {
          //print('API Cevabı: $data');
        } // Gelen ham veriyi kontrol et

        // JSON verisini ProjectDetailsModel listesine dönüştür
        List<ProjectModel> projects = data.map((item) => ProjectModel.fromJson(item)).toList();
        if (kDebugMode) {
          print('Proje Sayısı: ${projects.length}');
        }
        return projects;
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
        }
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchFilteredProjects): $e');
      }
      return [];
    }
  }
}
