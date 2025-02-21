import 'dart:convert';
import 'package:common/common.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:misyonbank/product/models/document_model.dart';
import 'package:misyonbank/product/models/project/investment_projections_model.dart';
import 'package:misyonbank/product/models/project/project_create_highlights_model.dart';
import 'package:misyonbank/product/models/project/project_details_model.dart';
import 'package:misyonbank/product/models/project/project_documents_model.dart';
import 'package:misyonbank/product/models/project/project_finansial_model.dart';
import 'package:misyonbank/product/models/project/project_funding_info_model.dart';
import 'package:misyonbank/product/models/project/project_investment_info_model.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/models/project/project_filter_model.dart';
import 'package:misyonbank/product/models/project/project_summary_model.dart';
import 'package:misyonbank/product/models/project/project_team_model.dart';
import 'package:misyonbank/product/models/project/project_trophies_model.dart';

class FetcherStaticService {
  static testRequest() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({});
    var dio = Dio();
    var response = await dio.request(
      'https://crwdapi.nexasoft.io/api/projectdbit/getfilteredprojects',
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
    const String url = 'https://crwdapi.nexasoft.io/api/projectdbit/getfilteredprojects';
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

  static Future<ProjectDetailsModel?> fetchProjectDetails({required String projectID}) async {
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectdetails?projectId=$projectID';
    ProjectDetailsModel? model;
    try {
      final dio.Response response = await dioObj.request(
        url,
        options: Options(
          method: 'GET',
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

  static Future<ProjectSummaryModel?> fetchProjectSummary({required String projectID}) async {
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectsummary?projectId=$projectID';
    ProjectSummaryModel? model;
    try {
      final dio.Response response = await dioObj.request(
        url,
        options: Options(
          method: 'GET',
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
      final dio.Response response = await dioObj.request(
        url,
        options: Options(
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];
        model = ProjectFundingInfoModel.fromJson(projectID: projectID, json: data);
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
    String url = 'https://crwdapi.nexasoft.io/api/projectdbit/getprojectabout?projectId=$projectID';
    //ProjectFundingInfoModel? model;
    try {
      final dio.Response response = await dioObj.request(
        url,
        options: Options(
          method: 'GET',
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
      final dio.Response response = await dioObj.request(
        url,
        options: Options(
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];
        model = ProjectInvestmentInfoModel.fromJson(projectID: projectID, json: data);
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

  static Future<List<ProjectCreateHighlightsModel>?> fetchProjectHighlights(
      {required String projectID, required String token}) async {
    token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjM0MGYxYzllLTVlYjktZWYxMS04Mzg2LTAwNTA1NmIwY2Y4MSIsIm5iZiI6MTczNzYzMTEyNiwiZXhwIjoxNzY5MTY3MTI2LCJpYXQiOjE3Mzc2MzExMjZ9.jO1TfNivb-2Krf47cgI3v3OnNyRy8tMGHPMh9vqHz5k';
    projectID = "5982e0c9-68b9-ef11-8386-005056b0cf81";
    if (token.isEmpty) {
      return null;
    }
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectcreatehighlightsbyprojectid?projectId=$projectID';
    List<ProjectCreateHighlightsModel> model = [];
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        List data = response.data['data'];
        model = data
            .map(
              (e) => ProjectCreateHighlightsModel.fromJson(e),
            )
            .toList();
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectHighlights): $e');
      }
      return null;
    }
  }

  static Future<List<InvestmentProjection>?> fetchInvestmentProjections(
      {required String projectID}) async {
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getinvestmentprojectionsbyprojectid?projectId=$projectID';
    List<InvestmentProjection> model = [];
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
        List data = response.data['data'];
        model = data
            .map(
              (e) => InvestmentProjection.fromJson(e),
            )
            .toList();
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchInvestmentProjections): $e');
      }
      return null;
    }
  }

  static Future<ProjectTeamModel?> fetchProjectTeam(
      {required String projectID, required String token}) async {
    token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjM0MGYxYzllLTVlYjktZWYxMS04Mzg2LTAwNTA1NmIwY2Y4MSIsIm5iZiI6MTczNzYzMTEyNiwiZXhwIjoxNzY5MTY3MTI2LCJpYXQiOjE3Mzc2MzExMjZ9.jO1TfNivb-2Krf47cgI3v3OnNyRy8tMGHPMh9vqHz5k';
    projectID = "5982e0c9-68b9-ef11-8386-005056b0cf81";
    if (token.isEmpty) {
      return null;
    }
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectmember/getprojectteam?projectId=$projectID';
    ProjectTeamModel? model;
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];

        model = ProjectTeamModel.fromJson(data);
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectTeam): $e');
      }
      return null;
    }
  }

  static Future<List<ProjectTrophiesModel>?> fetchProjectTrophies(
      {required String projectID, required String token}) async {
    token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjM0MGYxYzllLTVlYjktZWYxMS04Mzg2LTAwNTA1NmIwY2Y4MSIsIm5iZiI6MTczNzYzMTEyNiwiZXhwIjoxNzY5MTY3MTI2LCJpYXQiOjE3Mzc2MzExMjZ9.jO1TfNivb-2Krf47cgI3v3OnNyRy8tMGHPMh9vqHz5k';
    projectID = "ce779f40-91c3-ef11-8386-005056b0cf81";
    if (token.isEmpty) {
      return null;
    }
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectcreatetrophiesbyprojectid?projectId=$projectID';
    List<ProjectTrophiesModel> trophiesList = [];
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        List data = response.data['data'];

        trophiesList = data.map((item) => ProjectTrophiesModel.fromJson(item)).toList();
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return trophiesList;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectTropies): $e');
      }
      return null;
    }
  }

  static Future<ProjectDocumentsModel?> fetchProjectDocuments(
      {required String projectID, required String token}) async {
    token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjM0MGYxYzllLTVlYjktZWYxMS04Mzg2LTAwNTA1NmIwY2Y4MSIsIm5iZiI6MTczNzYzMTEyNiwiZXhwIjoxNzY5MTY3MTI2LCJpYXQiOjE3Mzc2MzExMjZ9.jO1TfNivb-2Krf47cgI3v3OnNyRy8tMGHPMh9vqHz5k';
    projectID = "5982e0c9-68b9-ef11-8386-005056b0cf81";
    if (token.isEmpty) {
      return null;
    }
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdocument/getprojectdocuments?projectId=$projectID';
    ProjectDocumentsModel? model;
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];

        model = ProjectDocumentsModel.fromJson(data);
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectDocuments): $e');
      }
      return null;
    }
  }

  static Future<List<ProjectFinancialModel>?> fetchProjectFinansials(
      {required String projectID}) async {
    final Dio dioObj = Get.find();
    String url =
        'https://crwdapi.nexasoft.io/api/projectdbit/getprojectfinancialbyprojectid?projectId=$projectID';
    List<ProjectFinancialModel> model = [];
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
        List data = response.data['data'];
        model = data
            .map(
              (e) => ProjectFinancialModel.fromJson(e),
            )
            .toList();
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchProjectFinansials): $e');
      }
      return null;
    }
  }

  static Future<DocumentModel?> fetchDocument(
      {required String docID, required String token}) async {
    token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjM0MGYxYzllLTVlYjktZWYxMS04Mzg2LTAwNTA1NmIwY2Y4MSIsIm5iZiI6MTczNzYzMTEyNiwiZXhwIjoxNzY5MTY3MTI2LCJpYXQiOjE3Mzc2MzExMjZ9.jO1TfNivb-2Krf47cgI3v3OnNyRy8tMGHPMh9vqHz5k';
    docID = "edb69e0b-b2bb-ef11-8386-005056b0cf81";
    if (token.isEmpty) {
      return null;
    }
    final Dio dioObj = Get.find();
    String url = 'https://crwdapi.nexasoft.io/api/document/getdocument?documentId=$docID';
    DocumentModel? model;
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['result']) {
        Map<String, dynamic> data = response.data['data'];

        model = DocumentModel.fromJson(data);
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
      }
      return model;
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası(fetchDocument): $e');
      }
      return null;
    }
  }
}
