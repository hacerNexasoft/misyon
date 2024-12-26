import 'package:common/common.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:misyonbank/product/models/widget_models/community_item_model.dart';
import 'package:misyonbank/product/models/projects_model.dart';
import 'package:misyonbank/product/models/projects_details_model.dart'; // Detay model eklendi
import 'package:misyonbank/product/services/project_service.dart';
import 'package:misyonbank/product/services/projects_service.dart';

class FonvestorViewController extends BaseGetxController {
  // Servis tanımlamaları
  final ProjectsService _projectsService = Get.find<ProjectsService>();
  final ScrollController scrollController = ScrollController();
  final _projectService = Get.find<ProjectService>();

  RxList<ProjectModel?> get openInvestmentsOpportunities =>
      _projectService.openInvestmentsOpportunities;
  RxList<ProjectModel?> get preOrderCollectors =>
      _projectService.preOrderCollectors;
  RxList<ProjectModel?> get upcomingCollectors =>
      _projectService.upcomingCollectors;
  RxList<ProjectModel?> get completedCollectors =>
      _projectService.completedCollectors;

  RxList<CommunityItemModel?> get communityList =>
      _projectService.communityList;

  // API'den gelen projeler
  RxList<ProjectDetailsModel> projectsList = <ProjectDetailsModel>[].obs;

  // Banner
  final List<String> investmentBanner = [
    AssetConstants.investmentBanner,
    AssetConstants.investmentBanner1
  ];

  // **API çağrısı ve kontrol**
  @override
  void onInit() {
    super.onInit();
    fetchProjects(); // Projeleri çekme işlemini başlat
  }

  // Projeleri API'den çek
  Future<void> fetchProjects() async {
    try {
      // Örnek bir istek modeli oluştur
      ProjectsModel requestModel = ProjectsModel(
        stateFilters: [0], // Örnek filtreler
        categories: ["00000000-0000-0000-0000-000000000000"],
        cities: ["00000000-0000-0000-0000-000000000000"],
        pageInfo: PageInfo(pageNumber: 0, count: 0),
      );

      // Servisi çağır ve listeyi güncelle
      await _projectsService.getFilteredProjects(requestModel);
      projectsList.value =
          _projectsService.projectDetailsList; // Listeyi güncelle

      print('Çekilen Projeler: ${projectsList.length}');
    } catch (e) {
      print('Proje Çekme Hatası: $e');
    }
  }
}
