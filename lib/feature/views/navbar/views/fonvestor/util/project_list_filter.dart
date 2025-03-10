import 'package:common/common.dart';
import 'package:misyonbank/product/models/project/project_model.dart';

class ProjectListFilter {
  List<ProjectModel> projects;
  ProjectListFilter({required this.projects});

  List<ProjectModel> applySorting(
      {required String selection, required List<String> sortingOptions}) {
    if (selection == sortingOptions[0]) {
      projects.sort(
        (a, b) => b.fundingPercentage.compareTo(a.fundingPercentage),
      );
    } else if (selection == sortingOptions[1]) {
      projects.sort((a, b) => a.projectStartDate.compareTo(b.projectStartDate));
    } else if (selection == sortingOptions[2]) {
      projects.sort((a, b) => a.projectEndDate.compareTo(b.projectEndDate));
    } else if (selection == sortingOptions[3]) {
      projects.sort((a, b) => b.numberOfInvestors.compareTo(a.numberOfInvestors));
    } else if (selection == sortingOptions[4]) {
      projects.sort((a, b) => a.title.compareTo(b.title));
    } else if (selection == sortingOptions[5]) {
      projects.sort((a, b) => b.title.compareTo(a.title));
    }

    return projects;
  }

  List<ProjectModel> applyFilter(
      {String? selectedPeriod,
      int? selectedTerm,
      RangeValues? selectedRateOfEarnRange,
      List<String>? selectedCities,
      List<String>? selectedCategories}) {
    // Kategorilere göre filtreleme
    if (selectedCategories != null && selectedCategories.isNotEmpty) {
      projects =
          projects.where((project) => selectedCategories.contains(project.category)).toList();
    }
    // Şehirlere göre filtreleme
    if (selectedCities != null && selectedCities.isNotEmpty) {
      projects = projects.where((project) => selectedCities.contains(project.city)).toList();
    }

    // Süreye göre filtreleme (Aylık veya Yıllık)
    if (selectedPeriod != null && selectedPeriod.isNotEmpty) {
      switch (selectedPeriod) {
        case "Aylık":
          projects = projects.where((project) => project.period == Period.Monthly).toList();
          break;
        case "Yıllık":
          projects = projects.where((project) => project.period == Period.Annual).toList();
          break;
        default:
        // Geçersiz bir süre seçildiyse işlem yapılmaz.
      }
    }
    // Vadeye göre filtreleme
    if (selectedTerm != null && selectedTerm != 0) {
      projects = projects.where((project) => project.termCode == selectedTerm).toList();
    }
    // Getiri oranına göre filtreleme
    if (selectedRateOfEarnRange != null &&
        selectedRateOfEarnRange.start != 0 &&
        selectedRateOfEarnRange.end != 0 &&
        selectedRateOfEarnRange.start < selectedRateOfEarnRange.end) {
      projects = projects
          .where((project) =>
              project.yearlyReturnRate >= selectedRateOfEarnRange.start &&
              project.yearlyReturnRate <= selectedRateOfEarnRange.end)
          .toList();
    }

    return projects;
  }
}
