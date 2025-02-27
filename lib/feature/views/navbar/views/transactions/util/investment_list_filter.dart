import 'package:misyonbank/product/models/investment_models/investment_model.dart';

class InvestmentListFilter {
  String selectedPeriod;
  List<String> tags;
  DateTime? startDate;
  DateTime? endDate;

  List<InvestmentModel> filteredCompletedInvestmentsList = [];
  List<InvestmentModel> filtereedWaitingInvestmentsList = [];
  List<InvestmentModel> filteredFailedInvestmentsList = [];

  InvestmentListFilter({
    required this.selectedPeriod,
    required this.tags,
    this.startDate,
    this.endDate,
  });

  void applyFilter(
      {required List<InvestmentModel> completedInvestmentsList,
      required List<InvestmentModel> waitingInvestmentsList,
      required List<InvestmentModel> failedInvestmentsList}) {
    if (startDate != null && endDate != null) {
      completedInvestmentsList.removeWhere((element) =>
          element.investmentDate.isBefore(startDate!) || element.investmentDate.isAfter(endDate!));
      waitingInvestmentsList.removeWhere((element) =>
          element.investmentDate.isBefore(startDate!) || element.investmentDate.isAfter(endDate!));
      failedInvestmentsList.removeWhere((element) =>
          element.investmentDate.isBefore(startDate!) || element.investmentDate.isAfter(endDate!));
    } else if (selectedPeriod.isNotEmpty) {
      DateTime now = DateTime.now();
      switch (selectedPeriod) {
        case "Bugün":
          completedInvestmentsList.removeWhere((element) =>
              element.investmentDate.day != now.day ||
              element.investmentDate.month != now.month ||
              element.investmentDate.year != now.year);
          waitingInvestmentsList.removeWhere((element) =>
              element.investmentDate.day != now.day ||
              element.investmentDate.month != now.month ||
              element.investmentDate.year != now.year);
          failedInvestmentsList.removeWhere((element) =>
              element.investmentDate.day != now.day ||
              element.investmentDate.month != now.month ||
              element.investmentDate.year != now.year);
          break;
        case "Son 7 Gün":
          completedInvestmentsList.removeWhere(
              (element) => element.investmentDate.isBefore(now.subtract(const Duration(days: 7))));
          waitingInvestmentsList.removeWhere(
              (element) => element.investmentDate.isBefore(now.subtract(const Duration(days: 7))));
          failedInvestmentsList.removeWhere(
              (element) => element.investmentDate.isBefore(now.subtract(const Duration(days: 7))));
          break;
        case "Son 1 Ay":
          completedInvestmentsList.removeWhere(
              (element) => element.investmentDate.isBefore(now.subtract(const Duration(days: 30))));
          waitingInvestmentsList.removeWhere(
              (element) => element.investmentDate.isBefore(now.subtract(const Duration(days: 30))));
          failedInvestmentsList.removeWhere(
              (element) => element.investmentDate.isBefore(now.subtract(const Duration(days: 30))));
          break;
        case "Son 3 Ay":
          completedInvestmentsList.removeWhere(
              (element) => element.investmentDate.isBefore(now.subtract(const Duration(days: 90))));
          waitingInvestmentsList.removeWhere(
              (element) => element.investmentDate.isBefore(now.subtract(const Duration(days: 90))));
          failedInvestmentsList.removeWhere(
              (element) => element.investmentDate.isBefore(now.subtract(const Duration(days: 90))));
          break;
        case "Son 6 Ay":
          completedInvestmentsList.removeWhere((element) =>
              element.investmentDate.isBefore(now.subtract(const Duration(days: 180))));
          waitingInvestmentsList.removeWhere((element) =>
              element.investmentDate.isBefore(now.subtract(const Duration(days: 180))));
          failedInvestmentsList.removeWhere((element) =>
              element.investmentDate.isBefore(now.subtract(const Duration(days: 180))));
          break;
        case "Son 1 Yıl":
          completedInvestmentsList.removeWhere((element) =>
              element.investmentDate.isBefore(now.subtract(const Duration(days: 365))));
          waitingInvestmentsList.removeWhere((element) =>
              element.investmentDate.isBefore(now.subtract(const Duration(days: 365))));
          failedInvestmentsList.removeWhere((element) =>
              element.investmentDate.isBefore(now.subtract(const Duration(days: 365))));
          break;
        default:
      }
    }

    /*if (tags.isNotEmpty) {
      if (tags.contains("Alış")) {
        completedInvestmentsList.removeWhere((element) => element.committedInvestment <= 0);
        waitingInvestmentsList.removeWhere((element) => element.committedInvestment <= 0);
        failedInvestmentsList.removeWhere((element) => element.committedInvestment <= 0);
      }
      if (tags.contains("Getiri")) {
        completedInvestmentsList.removeWhere((element) => element.committedInvestment <= 0);
        waitingInvestmentsList.removeWhere((element) => element.committedInvestment <= 0);
        failedInvestmentsList.removeWhere((element) => element.committedInvestment <= 0);
      }
    }*/
    filteredCompletedInvestmentsList = completedInvestmentsList;
    filtereedWaitingInvestmentsList = waitingInvestmentsList;
    filteredFailedInvestmentsList = failedInvestmentsList;
  }
}
