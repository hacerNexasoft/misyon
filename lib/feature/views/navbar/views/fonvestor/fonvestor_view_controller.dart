import 'package:common/common.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/models/master_data_model.dart';
import 'package:misyonbank/product/models/project/project_model.dart'; // Detay model eklendi
import 'package:misyonbank/product/models/widget_models/community_item_model.dart';
import 'package:misyonbank/product/services/project_service.dart';

class FonvestorViewController extends BaseGetxController {
  // Servis tanımlamaları
  final ScrollController scrollController = ScrollController();
  final _projectService = Get.find<ProjectService>();

  RxBool get isDatasReady => _projectService.isAllFetched;

  //RxList<ProjectModel> get projectsAll => _projectService.projectsList;
  RxList<ProjectModel> get activeProjects => _projectService.activeProjects;
  RxList<ProjectModel> get upcomingProjects => _projectService.upcomingProjects;
  RxList<ProjectModel> get succeededProjects => _projectService.succeededProjects;
  List<ProjectModel> get upcomingPrerelease => _projectService.upcomingProjects
      .where((p) => p.status == ProjectStatus.upcomingPrerelease)
      .toList();
  List<ProjectModel> get upcomingPreview => _projectService.upcomingProjects
      .where((p) => p.status == ProjectStatus.upcomingPreview)
      .toList();
  List<ProjectModel> get upcomingDetailedPrerelease => _projectService.upcomingProjects
      .where((p) => p.status == ProjectStatus.upcomingDetailedPrerelease)
      .toList();

  RxList<CommunityItemModel?> get communityList => _projectService.communityList;

  RxList<Category> get categoryList {
    if (_projectService.masterData.value == null) {
      return <Category>[].obs;
    }
    return _projectService.masterData.value!.categories.obs;
  }

  // Banner
  final List<String> investmentBanner = [
    AssetConstants.investmentBanner,
    AssetConstants.investmentBanner1
  ];

  // **API çağrısı ve kontrol**
  /* @override
  void onInit() async {
    super.onInit();
  }*/
}
