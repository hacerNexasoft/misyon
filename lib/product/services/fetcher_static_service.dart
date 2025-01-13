import 'package:common/common.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:misyonbank/product/models/project_filter_model.dart';

class FetcherStaticService {
  // API'den veri çekme
  static Future<List<ProjectModel>> fetchFilteredProjects(
      {ProjectFilterModel? requestModel}) async {
    final Dio dioObj = Get.find();
    const String url =
        'https://crwdapi.nexasoft.io/api/project/getfilteredprojects';

    try {
      final dio.Response response = await dioObj.post(
        url,
        data: requestModel != null
            ? requestModel.toJson()
            : {}, // JSON formatında gönderiyoruz
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data']; // API verisi
        if (kDebugMode) {
          //print('API Cevabı: $data');
        } // Gelen ham veriyi kontrol et

        // JSON verisini ProjectDetailsModel listesine dönüştür
        List<ProjectModel> projects =
            data.map((item) => ProjectModel.fromJson(item)).toList();
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
        print('API İstek Hatası: $e');
      }
      return [];
    }
  }
}
