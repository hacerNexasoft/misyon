import 'package:common/common.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:misyonbank/product/models/projects_details_model.dart';
import 'package:misyonbank/product/models/projects_model.dart';

class ProjectsService extends GetxService {
  final Rx<List<ProjectDetailsModel>> _projectDetailsList =
      Rx<List<ProjectDetailsModel>>([]);
  List<ProjectDetailsModel> get projectDetailsList => _projectDetailsList.value;
  final Dio _dio = Get.find();

  // API'den veri çekme
  Future<void> getFilteredProjects(ProjectsModel requestModel) async {
    const String url =
        'https://crwdapi.nexasoft.io/api/project/getfilteredprojects';

    try {
      final dio.Response response = await _dio.post(
        url,
        data: requestModel.toJson(), // JSON formatında gönderiyoruz
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data']; // API verisi
        print('API Cevabı: $data'); // Gelen ham veriyi kontrol et

        // JSON verisini ProjectDetailsModel listesine dönüştür
        List<ProjectDetailsModel> projects =
            data.map((item) => ProjectDetailsModel.fromJson(item)).toList();

        _projectDetailsList.value = projects;

        print('Proje Sayısı: ${projects.length}');
      } else {
        print('Hata Kodu: ${response.statusCode}');
      }
    } catch (e) {
      print('API İstek Hatası: $e');
    }
  }
}
