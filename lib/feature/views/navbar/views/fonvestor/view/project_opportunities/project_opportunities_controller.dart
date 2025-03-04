import 'package:common/common.dart';
import 'package:misyonbank/feature/components/investment_card_comp/list_filtering_comp/list_filtering_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/util/project_list_filter.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/services/project_service.dart';
import 'package:misyonbank/product/utils/extensions.dart';

class ProjectOpportunitiesController extends BaseGetxController {
  final _projectService = Get.find<ProjectService>();
  var bottompress = false.obs;
  var statuses = ProjectOpportunityDetail.values.toList();
  var selectedStatus = ProjectOpportunityDetail.all.obs;
  var selectedRateOfEarnRange = const RangeValues(0, 0).obs;
  String selectedSortingOptions = '';
  RxString selectedPeriod = ''.obs;
  RxInt selectedTerm = 0.obs;
  RxList<String> selectedCities = <String>[].obs;
  RxList<String> selectedCategories = <String>[].obs;
  var showAllCities = false.obs;
  var showAllCategories = false.obs;

  final List<String> sortingOptions = [
    'En Çok Yatırım Alan (%)',
    'En Yeni',
    'Yakında Kapanan',
    'En Çok Yatırımcısı Olan',
    'Alfabetik (A-Z)',
    'Alfabetik (Z-A)'
  ];

  final List<String> periods = [
    "Aylık",
    "Yıllık",
  ];

  final List<int> terms = [6, 12, 18, 24, 36, 48];
  List<String> cities = [];

  List<String> categories = [];

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is String) {
      String headerTitle = Get.arguments as String;

      selectedStatus.value = ProjectOpportunityExtension.fromDescription(headerTitle);
    }
    cities = _projectService.allProjectsList.map((e) => e.city).toSet().toList();
    categories = _projectService.masterData.value!.categories.map((e) => e.value).toList();
  }

  void onClickfilterButton() {
    bottompress.value = true;
    update();
  }

  List<String> get visibleCities => showAllCities.value ? cities : cities.take(9).toList();

  List<String> get visibleCategories =>
      showAllCategories.value ? categories : categories.take(3).toList();

  List<ProjectModel> get filteredProjects {
    List<ProjectModel> filteredList = [];
    switch (selectedStatus.value) {
      case ProjectOpportunityDetail.all:
        filteredList = _projectService.allProjectsList;
        break;

      case ProjectOpportunityDetail.successful:
        filteredList = _projectService.succeededProjects;
        break;

      case ProjectOpportunityDetail.favorite:
        final projectIds = _projectService.favoriteProjects.map((fp) => fp.projectId).toSet();

        filteredList = _projectService.allProjectsList
            .where((element) => projectIds.contains(element.id))
            .toList()
            .obs;
        break;

      case ProjectOpportunityDetail.active:
        filteredList = _projectService.activeProjects;
        break;

      case ProjectOpportunityDetail.upcoming:
        filteredList = _projectService.upcomingProjects;
        break;

      default:
        return <ProjectModel>[].obs;
    }
    if (selectedSortingOptions.isNotEmpty) {
      filteredList = ProjectListFilter(projects: filteredList.toList())
          .applySorting(selection: selectedSortingOptions, sortingOptions: sortingOptions);
    }
    if (bottompress.value) {
      filteredList = ProjectListFilter(projects: filteredList.toList()).applyFilter(
          selectedPeriod: selectedPeriod.value,
          selectedTerm: selectedTerm.value,
          selectedRateOfEarnRange: selectedRateOfEarnRange.value,
          selectedCategories: selectedCategories,
          selectedCities: selectedCities);
    }
    return filteredList;
  }

  void resetAllSelected() {
    selectedTerm.value = 0;
    selectedPeriod.value = '';
    selectedCities.value = [];
    selectedCategories.value = [];
    selectedRateOfEarnRange.value = const RangeValues(0, 0);
    bottompress.value = false;
    update();
  }

  void toggleShowAllCategories() {
    showAllCategories.value = !showAllCategories.value;
  }

  void updateSelectedPeriod(String newDuration) {
    selectedPeriod.value = newDuration;
  }

  void onSelectStatus(ProjectOpportunityDetail selected) {
    selectedStatus.value = selected;
    update();
  }

  void onSelectSortingOption(String selected) {
    selectedSortingOptions = selected;
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
        selectedItem: selectedSortingOptions,
        onApply: (selected) {
          onSelectSortingOption(selected!);
        },
      ),
    );
  }

  void onProjectRangeChanged(RangeValues rangeValues) {
    selectedRateOfEarnRange.value = rangeValues;
    update();
  }

  void onProjectRangeDelete(RangeValues rangeValues) {
    selectedRateOfEarnRange.value = rangeValues;
    update();
  }

  void toggleCitySelection(String city) {
    if (selectedCities.contains(city)) {
      selectedCities.remove(city);
    } else {
      selectedCities.add(city);
    }
  }

  void toggleShowAllCities() {
    showAllCities.value = !showAllCities.value;
    update();
  }

  bool isTermSelected(int term) {
    return selectedTerm.value == term;
  }

  void selectTerm(int term) {
    selectedTerm.value = term;
  }

  bool isSectorSelected(String sector) {
    return selectedCategories.contains(sector);
  }

  void toggleSectorSelection(String sector, bool isSelected) {
    if (isSelected) {
      selectedCategories.add(sector);
      update();
    } else {
      selectedCategories.remove(sector);
      update();
    }
  }

  bool isPeriodSelected(String duration) {
    return selectedPeriod.value == duration;
  }

  void selectPeriod(String period) {
    selectedPeriod.value = period;
    update();
  }
}
