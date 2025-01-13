import 'package:common/common.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/models/investment_model.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:misyonbank/product/models/widget_models/community_item_model.dart'; // Detay model eklendi
import 'package:misyonbank/product/services/project_service.dart';

class FonvestorViewController extends BaseGetxController {
  // Servis tanımlamaları
  final ScrollController scrollController = ScrollController();
  final _projectService = Get.find<ProjectService>();

  RxBool get isReady => _projectService.isAllFetched;

  RxList<ProjectModel> get projects => _projectService.projectsList;

  RxList<ProjectModel> get openInvestmentsOpportunities =>
      _projectService.openInvestmentsOpportunities;
  RxList<ProjectModel> get preOrderCollectors =>
      _projectService.preOrderCollectors;
  RxList<ProjectModel> get upcomingCollectors =>
      _projectService.upcomingCollectors;
  RxList<InvestmentModel?> get completedCollectors =>
      _projectService.completedCollectors;
  RxList<CommunityItemModel?> get communityList =>
      _projectService.communityList;

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
