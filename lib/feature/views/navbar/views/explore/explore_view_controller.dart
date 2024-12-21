import 'package:common/common.dart';
import 'package:misyonbank/feature/components/project_card_comp/list_filtering_comp/list_filtering_comp.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/widget_models/community_item_model.dart';
import 'package:misyonbank/product/services/project_service.dart';

class ExploreViewController extends BaseGetxController
    with GetTickerProviderStateMixin {
  var recentInvestments = <CommunityItemModel?>[].obs;
  late TabController tabController;
  final _projectService = Get.find<ProjectService>();
  var selectedSortingOptions = ''.obs;
  final List<String> communityViewTabs = [
    LocalizationKeys.communityTabsInvestmentsTextKey.tr,
    LocalizationKeys.communityTabsUpdateTextKey.tr
  ];

  RxList<CommunityItemModel?> get communityList =>
      _projectService.communityList;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    fetchRecentInvestments();
  }

  Future<void> fetchRecentInvestments() async {
    try {
      change(null, status: RxStatus.loading());

      await _projectService.fetchCommunityInvestment();

      if (communityList.isEmpty) {
        change(null,
            status: RxStatus.error("Topluluk yatırımları bulunamadı."));
      } else {
        change(communityList, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      logger.e(e);
    }
  }

  final List<String> sortingOptions = [
    'En Yeni',
    'En Eski',
    'En Çok Yatırım Alan (%)',
    'En Çok Favorilere Alınan (%)',
  ];

  void changeTab(int newIndex) async {
    change(state, status: RxStatus.loading());
    tabController.animateTo(newIndex);
    change(state, status: RxStatus.success());
  }

  void onSelectSortingOption(String selected) {
    selectedSortingOptions.value = selected;
    update();
  }

  Future<void> sortingShowBottomSheet() async {
    await Get.dropdownBottomSheet(
      child: ListFilteringComp<String>(
        height: Get.height * 0.42,
        headerTitle: LocalizationKeys.sortKey.tr,
        items: sortingOptions,
        itemLabel: (option) => option,
        selectedItem: selectedSortingOptions.value,
        onApply: (selected) {
          onSelectSortingOption(selected!);
        },
      ),
    );
  }
}
