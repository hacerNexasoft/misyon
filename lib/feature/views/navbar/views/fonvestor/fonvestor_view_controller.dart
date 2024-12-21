import 'package:common/common.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:misyonbank/product/models/widget_models/community_item_model.dart';
import 'package:misyonbank/product/services/project_service.dart';

class FonvestorViewController extends BaseGetxController {
  final _projectService = Get.find<ProjectService>();
  final ScrollController scrollController = ScrollController();

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

  final List<String> investmentBanner = [
    AssetConstants.investmentBanner,
    AssetConstants.investmentBanner1
  ];
}
