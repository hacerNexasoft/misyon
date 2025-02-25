import 'package:common/common.dart';
import 'package:misyonbank/feature/components/investment_card_comp/list_filtering_comp/list_filtering_comp.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/services/project_service.dart';
import 'package:misyonbank/product/utils/extensions.dart';

class ProjectOpportunitiesController extends BaseGetxController {
  final _projectService = Get.find<ProjectService>();
  var bottompress = false.obs;
  var statuses = ProjectOpportunityDetail.values.toList();
  var selectedStatus = ProjectOpportunityDetail.all.obs;
  var selectedProjectRange = const RangeValues(10, 150).obs;
  var selectedSortingOptions = ''.obs;
  RxString selectedDuration = ''.obs;
  RxString selectedMaturities = ''.obs;
  RxList<String> selectedTags = <String>[].obs;
  RxList<String> selectedSectors = <String>[].obs;
  var showAllTags = false.obs;
  var showAllSectors = false.obs;
  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is String) {
      String headerTitle = Get.arguments as String;

      selectedStatus.value = ProjectOpportunityExtension.fromDescription(headerTitle);
    }
  }

  final List<String> sortingOptions = [
    'En Çok Yatırım Alan (%)',
    'En Yeni',
    'Yakında Kapanan',
    'En Çok Favorilere Alınan',
    'Alfabetik (A-Z)',
    'Alfabetik (Z-A)'
  ];

  final List<String> durations = [
    "Aylık",
    "3 Ay",
  ];

  final List<String> maturities = ["6 Ay", "12 Ay", "18 Ay", "24 Ay"];
  final List<String> tags = [
    'B2B',
    'Abonelik',
    'B2C',
    'B2G',
    'SaaS',
    'Reklam',
    'Freemium',
    'Blockchain',
    'KOSGEB Destekli',
    'Abonelik2',
    'B2C2',
  ];

  final List<String> sectors = [
    'Yapay Zeka',
    'Enerji',
    'Tarım',
    'Tarım2',
  ];
  void filteredBottomPress() {
    bottompress.value = true;
    update();
  }

  List<String> get visibleTags => showAllTags.value ? tags : tags.take(9).toList();

  List<String> get visibleSectors => showAllSectors.value ? sectors : sectors.take(3).toList();

  RxList<ProjectModel> get filteredProjects {
    switch (selectedStatus.value) {
      case ProjectOpportunityDetail.all:
        return _projectService.allProjectsList;

      case ProjectOpportunityDetail.successful:
        return _projectService.succeededProjects;

      case ProjectOpportunityDetail.favorite:
        final projectIds = _projectService.favoriteProjects.map((fp) => fp.projectId).toSet();

        return _projectService.allProjectsList
            .where((element) => projectIds.contains(element.id))
            .toList()
            .obs;

      case ProjectOpportunityDetail.active:
        return _projectService.activeProjects;

      case ProjectOpportunityDetail.upcoming:
        return _projectService.upcomingProjects;

      default:
        return <ProjectModel>[].obs;
    }
  }

  void resetAllSelected() {
    selectedMaturities.value = '';
    selectedDuration.value = '';
    selectedTags.value = [];
    selectedSectors.value = [];
    bottompress.value = false;
  }

  void toggleShowAllSectors() {
    showAllSectors.value = !showAllSectors.value;
  }

  void updateSelectedDuration(String newDuration) {
    selectedDuration.value = newDuration;
  }

  void onSelectStatus(ProjectOpportunityDetail selected) {
    selectedStatus.value = selected;
    update();
  }

  void onSelectSortingOption(String selected) {
    selectedSortingOptions.value = selected;
    update();
  }

  Future<void> showBottomSheet() async {
    await Get.dropdownBottomSheet(
      child: ListFilteringComp<ProjectOpportunityDetail>(
        height: Get.height * 0.6,
        headerTitle: LocalizationKeys.listViewKey.tr,
        items: statuses,
        itemLabel: (status) => status.description,
        selectedItem: selectedStatus.value,
        onApply: (selected) {
          onSelectStatus(selected!);
        },
      ),
    );
  }

  Future<void> sortingShowBottomSheet() async {
    await Get.dropdownBottomSheet(
      child: ListFilteringComp<String>(
        height: Get.height * 0.6,
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

  void onProjectRangeChanged(RangeValues rangeValues) {
    selectedProjectRange.value = rangeValues;
    update();
  }

  void onProjectRangeDelete(RangeValues rangeValues) {
    selectedProjectRange.value = rangeValues;
    update();
  }

  void toggleTagSelection(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  void toggleShowAllTags() {
    showAllTags.value = !showAllTags.value;
    update();
  }

  bool isMaturitySelected(String maturity) {
    return selectedMaturities.value == maturity;
  }

  void selectMaturity(String maturity) {
    selectedMaturities.value = maturity;
  }

  bool isSectorSelected(String sector) {
    return selectedSectors.contains(sector);
  }

  void toggleSectorSelection(String sector, bool isSelected) {
    if (isSelected) {
      selectedSectors.add(sector);
      update();
    } else {
      selectedSectors.remove(sector);
      update();
    }
  }

  bool isDurationSelected(String duration) {
    return selectedDuration.value == duration;
  }

  void selectDuration(String duration) {
    selectedDuration.value = duration;
    update();
  }
}
