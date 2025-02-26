import 'dart:convert';
import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:misyonbank/product/config/network.dart';
import 'package:misyonbank/product/models/investment_models/investment_model.dart';
import 'package:misyonbank/product/models/master_data_model.dart';
import 'package:misyonbank/product/models/project/favorite_project_model.dart';
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

  static Future<List<FavoriteProjectModel>> fetchFavoriteProjects({required String token}) async {
    if (token.isEmpty) {
      return [];
    }
    final Dio dioObj = Get.find();
    String url = '$baseURL/favoriteproject/getfavoriteprojects';
    List<FavoriteProjectModel> list = [];
    try {
      final response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        List data = response.data['data']['favoriteProjects'];

        list = data
            .map(
              (e) => FavoriteProjectModel.fromJson(e),
            )
            .toList();
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return list;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchFavoriteProjects): $e');
      }
      return [];
    }
  }

  static Future<MasterDataModel?> fetchMasterData() async {
    const String url = '$baseURL/crm/getmasterdata';
    final Dio dioObj = Get.find();
    MasterDataModel? masterData;
    try {
      var response = await dioObj.get(
        url,
        data: null,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];

        masterData = MasterDataModel.fromJson(data);

        return masterData;
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchMasterData): $e');
      }
      return null;
    }
  }

  static Future<List<InvestmentModel>> fetchAllInvestments({required String token}) async {
    List<InvestmentModel> list = [];
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var data = json.encode({"investmentState": 0});

      Dio dio = Get.find();
      var response = await dio.request(
        '$baseURL/portfoliodbit/getinvestments',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200 && response.data['result']) {
        //Data Geldi
        List data = response.data['data']['investments'];

        list = data
            .map(
              (e) => InvestmentModel.fromJson(e),
            )
            .toList();
        if (kDebugMode) {
          print('Çekilen Investments: ${list.length}');
        }
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return list;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchInvestments): $e');
      }
      return [];
    }
  }
}
