import 'package:common/common.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:misyonbank/product/services/project_service.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';

class YieldCalculationViewController extends BaseGetxController {
  final investAmountController = TextEditingController();
  final rateController = TextEditingController();
  final _projectService = Get.find<ProjectService>();

  RxList<ProjectModel?> get openInvestmentsOpportunities =>
      _projectService.openInvestmentsOpportunities;
  final investAmount = 0.0.obs;
  final borderColor = Colors.transparent.obs;
  final fillColor = AppColors.textFieldFillColor.obs;
  final textColor = AppColors.darkGreyColor.obs;
  final isButtonEnabled = false.obs;

  bool validateInputs() {
    if (investAmountController.text.isEmpty ||
        rateController.text.isEmpty ||
        selectedMaturity.value == 0) {
      return false;
    }
    return true;
  }

  final List<int> maturities = [1, 3, 6, 12, 24, 36, 48, 60];
  var selectedMaturity = 0.obs;

  static const double minInvestAmount = 1;
  static const double maxInvestAmount = 75000000;
  RxList<ProjectModel> filteredProjects = <ProjectModel>[].obs;
  void filterEarningRates() {
    double? targetRate = double.tryParse(rateController.text);
    if (targetRate == null) {
      filteredProjects.clear();
      return;
    }

    filteredProjects.value = openInvestmentsOpportunities
        .where((project) {
          return project?.earningRate?.toDouble() == targetRate;
        })
        .map((project) => project!)
        .toList();
    update();
  }

  void onInvestAmountChanged(String value) {
    if (value.isEmpty) {
      investAmount.value = 0;
    } else {
      investAmount.value =
          Formatter.convertFormattedAmountStringToDouble(value);
    }
    _updateTextFieldColors();
    _checkButtonEnableStatus();
  }

  void _checkButtonEnableStatus() {
    final amount = investAmount.value;
    isButtonEnabled.value = _isWithinRange(amount);
  }

  void _updateTextFieldColors() {
    final amount = investAmount.value;
    final isValid = _isWithinRange(amount) || amount == 0;

    borderColor.value =
        isValid ? AppColors.primaryColor : AppColors.primaryRedColor;
    fillColor.value = isValid
        ? AppColors.textFieldFillColor
        : AppColors.primaryRedColor.withOpacity(0.2);
    textColor.value = isValid ? AppColors.black : AppColors.primaryRedColor;
  }

  bool _isWithinRange(double amount) =>
      amount >= minInvestAmount && amount <= maxInvestAmount;

  Future<void> selectMaturity(BuildContext context) async {
    await Get.dropdownBottomSheet<int>(
        child: DropDownBottomSheet(
      items: maturities,
      isRatio: true,
      selectedItem: selectedMaturity.value,
      onSelect: onMaturitySelected,
      itemToString: (item) => '$item ${LocalizationKeys.monthTextKey.tr}',
    ));
  }

  void onMaturitySelected(int value) {
    selectedMaturity.value = value;
  }
}
