import 'package:common/common.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:misyonbank/product/models/project/project_details_model.dart';
import 'package:misyonbank/product/models/project/project_funding_info_model.dart';
import 'package:misyonbank/product/models/project/project_investment_info_model.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/models/project/project_filter_model.dart';
import 'package:misyonbank/product/models/project/project_summary_model.dart';

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

  static Future<ProjectDetailsModel?> fetchProjectDetails(
      {required String projectID}) async {
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectdetails?projectId=$projectID';
    ProjectDetailsModel? model;
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];
        model = ProjectDetailsModel.fromJson(id: projectID, json: data);
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectDetails): $e');
      }
      return null;
    }
  }

  static Future<ProjectSummaryModel?> fetchProjectSummary(
      {required String projectID}) async {
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectsummary?projectId=$projectID';
    ProjectSummaryModel? model;
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];
        model = ProjectSummaryModel.fromJson(json: data);
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectSummary): $e');
      }
      return null;
    }
  }

  static Future<ProjectFundingInfoModel?> fetchProjectFundingInfo(
      {required String projectID}) async {
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectfundinginfo?projectId=$projectID';
    ProjectFundingInfoModel? model;
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];
        model =
            ProjectFundingInfoModel.fromJson(projectID: projectID, json: data);
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectFundingInfo): $e');
      }
      return null;
    }
  }

  static Future<String?> fetchProjectAbout({required String projectID}) async {
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectabout?projectId=$projectID';
    //ProjectFundingInfoModel? model;
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];
        return data['description'];
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectFundingInfo): $e');
      }
      return null;
    }
  }

  static Future<ProjectInvestmentInfoModel?> fetchProjectInvestmentInfo(
      {required String projectID}) async {
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectinvestmentinfo?projectId=$projectID';
    ProjectInvestmentInfoModel? model;
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];
        model = ProjectInvestmentInfoModel.fromJson(
            projectID: projectID, json: data);
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectInvestmentInfo): $e');
      }
      return null;
    }
  }
}
