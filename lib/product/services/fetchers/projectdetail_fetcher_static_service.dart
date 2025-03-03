import 'package:common/common.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:misyonbank/product/models/document_model.dart';
import 'package:misyonbank/product/models/project/investment_projections_model.dart';
import 'package:misyonbank/product/models/project/project_comments_model.dart';
import 'package:misyonbank/product/models/project/project_create_highlights_model.dart';
import 'package:misyonbank/product/models/project/project_details_model.dart';
import 'package:misyonbank/product/models/project/project_documents_model.dart';
import 'package:misyonbank/product/models/project/project_faq_model.dart';
import 'package:misyonbank/product/models/project/project_finansial_model.dart';
import 'package:misyonbank/product/models/project/project_funding_info_model.dart';
import 'package:misyonbank/product/models/project/project_investment_info_model.dart';
import 'package:misyonbank/product/models/project/project_summary_model.dart';
import 'package:misyonbank/product/models/project/project_team_model.dart';
import 'package:misyonbank/product/models/project/project_trophies_model.dart';
import 'package:misyonbank/product/models/project/project_update_model.dart';
import '../../../configs/service/api_endpoints.dart';
import '../../models/project/favorite_project_model.dart';

class FonvestorService extends GetxService {
  static Map<String, dynamic> _defaultHeaders({String? token}) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  static Future<T?> _getModel<T>(
    String url, {
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final Dio dioObj = Get.find();
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(headers: headers ?? _defaultHeaders()),
      );
      if (response.statusCode == 200 && response.data['result'] == true) {
        final data = response.data['data'] as Map<String, dynamic>;
        return fromJson(data);
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası ($url): $e');
      }
      return null;
    }
  }

  static Future<List<T>?> _getList<T>(
    String url, {
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final Dio dioObj = Get.find();
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(headers: headers ?? _defaultHeaders()),
      );
      if (response.statusCode == 200 && response.data['result'] == true) {
        List data = response.data['data'];
        return data
            .map<T>((item) => fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası ($url): $e');
      }
      return null;
    }
  }

  static Future<T?> _postModel<T>(
      String url,
      dynamic payload, {
        Map<String, dynamic>? headers,
        required T Function(Map<String, dynamic>) fromJson,
      }) async {
    final Dio dioObj = Get.find();
    try {
      final dio.Response response = await dioObj.post(
        url,
        data: payload,
        options: Options(headers: headers ?? _defaultHeaders()),
      );
      if (response.statusCode == 200 && response.data['result'] == true) {
        final data = response.data['data'] as Map<String, dynamic>;
        return fromJson(data);
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('API POST İstek Hatası ($url): $e');
      }
      return null;
    }
  }

  static Future<List<T>?> _postList<T>(
      String url,
      dynamic payload, {
        Map<String, dynamic>? headers,
        required T Function(Map<String, dynamic>) fromJson,
      }) async {
    final Dio dioObj = Get.find();
    try {
      final dio.Response response = await dioObj.post(
        url,
        data: payload,
        options: Options(headers: headers ?? _defaultHeaders()),
      );
      if (response.statusCode == 200 && response.data['result'] == true) {
        List data = response.data['data'];
        return data
            .map<T>((item) =>
            fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('API POST İstek Hatası ($url): $e');
      }
      return null;
    }
  }

  static Future<ProjectDetailsModel?> fetchProjectDetails({
    required String projectID,
  }) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectDetailsDbit}?projectId=$projectID';
    return _getModel<ProjectDetailsModel>(
      url,
      fromJson: (data) =>
          ProjectDetailsModel.fromJson(id: projectID, json: data),
    );
  }

  static Future<ProjectSummaryModel?> fetchProjectSummary({
    required String projectID,
  }) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectSummaryDbit}?projectId=$projectID';
    return _getModel<ProjectSummaryModel>(
      url,
      fromJson: (data) => ProjectSummaryModel.fromJson(json: data),
    );
  }

  static Future<ProjectFundingInfoModel?> fetchProjectFundingInfo({
    required String projectID,
  }) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectFundingInfoDbit}?projectId=$projectID';
    return _getModel<ProjectFundingInfoModel>(
      url,
      fromJson: (data) =>
          ProjectFundingInfoModel.fromJson(projectID: projectID, json: data),
    );
  }

  static Future<String?> fetchProjectAbout({required String projectID}) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectAboutDbit}?projectId=$projectID';
    final Dio dioObj = Get.find();
    try {
      final dio.Response response = await dioObj.get(
        url,
        options: Options(headers: _defaultHeaders()),
      );
      if (response.statusCode == 200 && response.data['result'] == true) {
        final data = response.data['data'] as Map<String, dynamic>;
        return data['description'] as String?;
      } else {
        if (kDebugMode) {
          print('Hata Kodu: ${response.statusCode}');
          print('Exeption Detail: ${response.data['exceptionDetail']}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('API İstek Hatası (fetchProjectAbout): $e');
      }
      return null;
    }
  }

  static Future<ProjectInvestmentInfoModel?> fetchProjectInvestmentInfo({
    required String projectID,
  }) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectInvestmentInfoDbit}?projectId=$projectID';
    return _getModel<ProjectInvestmentInfoModel>(
      url,
      fromJson: (data) =>
          ProjectInvestmentInfoModel.fromJson(projectID: projectID, json: data),
    );
  }

  static Future<List<ProjectCreateHighlightsModel>?> fetchProjectHighlights({
    required String projectID,
    required String token,
  }) async {
    if (token.isEmpty) return null;
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectCreateHighlightsByProjectId}?projectId=$projectID';
    return _getList<ProjectCreateHighlightsModel>(
      url,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => ProjectCreateHighlightsModel.fromJson(data),
    );
  }

  static Future<List<InvestmentProjection>?> fetchInvestmentProjections({
    required String projectID,
  }) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getInvestmentProjectionsByProjectId}?projectId=$projectID';
    return _getList<InvestmentProjection>(
      url,
      fromJson: (data) => InvestmentProjection.fromJson(data),
    );
  }

  static Future<ProjectTeamModel?> fetchProjectTeam({
    required String projectID,
    required String token,
  }) async {
    if (token.isEmpty) return null;
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectTeam}?projectId=$projectID';
    return _getModel<ProjectTeamModel>(
      url,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => ProjectTeamModel.fromJson(data),
    );
  }

  static Future<List<ProjectTrophiesModel>?> fetchProjectTrophies({
    required String projectID,
    required String token,
  }) async {
    if (token.isEmpty) return null;
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectCreateTrophiesByProjectId}?projectId=$projectID';
    return _getList<ProjectTrophiesModel>(
      url,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => ProjectTrophiesModel.fromJson(data),
    );
  }

  static Future<ProjectDocumentsModel?> fetchProjectDocuments({
    required String projectID,
    required String token,
  }) async {
    if (token.isEmpty) return null;
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectDocumentsDocument}?projectId=$projectID';
    return _getModel<ProjectDocumentsModel>(
      url,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => ProjectDocumentsModel.fromJson(data),
    );
  }

  static Future<List<ProjectFinancialModel>?> fetchProjectFinansials({
    required String projectID,
  }) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectFinancialByProjectId}?projectId=$projectID';
    return _getList<ProjectFinancialModel>(
      url,
      fromJson: (data) => ProjectFinancialModel.fromJson(data),
    );
  }

  static Future<DocumentModel?> fetchDocument({
    required String docID,
    required String token,
  }) async {
    if (token.isEmpty) return null;
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getDocument}?documentId=$docID';
    return _getModel<DocumentModel>(
      url,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => DocumentModel.fromJson(data),
    );
  }

  static Future<List<ProjectUpdateModel>?> fetchProjectUpdates({
    required String projectID,
    required String token,
  }) async {
    if (token.isEmpty) return null;
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectUpdatesUpdate}?projectId=$projectID';
    return _getList<ProjectUpdateModel>(
      url,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => ProjectUpdateModel.fromJson(data),
    );
  }

  static Future<List<ProjectFaqModel>?> fetchProjectFaqs({
    required String projectID,
    required String token,
  }) async {
    if (token.isEmpty) return null;
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectFaqFaq}?projectId=$projectID';
    return _getList<ProjectFaqModel>(
      url,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => ProjectFaqModel.fromJson(data),
    );
  }

  static Future<List<ProjectCommentsModel>?> fetchProjectComments({
    required String projectID,
    required String token,
  }) async {
    if (token.isEmpty) return null;
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getProjectComments}?projectId=$projectID';
    return _getList<ProjectCommentsModel>(
      url,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => ProjectCommentsModel.fromJson(data),
    );
  }

  static Future<List<FavoriteProjectModel>?> fetchFavoriteProjects({
    required String token,
  }) async {
    if (token.isEmpty) return null;
    const url = '${ApiEndpoints.baseUrl}${ApiEndpoints.getFavoriteProjects}';
    return _getList<FavoriteProjectModel>(
      url,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => FavoriteProjectModel.fromJson(data),
    );
  }

  static Future<FavoriteProjectModel?> upsertProjectToFavorites({
    required String projectId,
    required String token,
  }) async {
    if (token.isEmpty) return null;
    const url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.upsertProjectToFavorites}';
    final payload = {"projectId": projectId};
    return _postModel<FavoriteProjectModel>(
      url,
      payload,
      headers: _defaultHeaders(token: token),
      fromJson: (data) => FavoriteProjectModel.fromJson(data),
    );
  }
}
