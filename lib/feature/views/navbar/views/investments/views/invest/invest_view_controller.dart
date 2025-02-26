import 'package:common/common.dart';
import 'package:misyonbank/feature/components/bottom_sheets/payment_type_selection/payment_type_selection_bottom_sheet_comp.dart';
import 'package:misyonbank/product/constants/app_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/bank_account_model.dart';
import 'package:misyonbank/product/models/bank_model.dart';
import 'package:misyonbank/product/models/investment_model_old.dart';
import 'package:misyonbank/product/models/payment_type_model.dart';
import 'package:misyonbank/product/models/investment_details_model.dart';
import 'package:misyonbank/product/services/bank_account_service.dart';
import 'package:misyonbank/product/services/bank_service.dart';
import 'package:misyonbank/product/services/project_service.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';

class InvestViewController extends BaseGetxController with GetTickerProviderStateMixin {
  final InvestmentDetailModel? projectDetailModel;
  final _bankAccountService = Get.find<BankAccountService>();

  InvestViewController(this.projectDetailModel);
  final _projectService = Get.find<ProjectService>();
  final amountTextController = TextEditingController();
  final craditAmountTextController = TextEditingController();
  final ibanTextController = TextEditingController();
  final recipientFullNameController = TextEditingController();
  final transactionAmountController = TextEditingController();
  final codeTextController = TextEditingController();
  final transactionDateController = TextEditingController();
  final paymentTypeController = TextEditingController();

  final investAmount = 0.0.obs;

  final transactionAmount = 0.0.obs;
  final selectedTabIndex = 0.obs;
  final isButtonEnabled = false.obs;
  final isCampaignAccepted = false.obs;
  final isRiskAccepted = false.obs;

  final borderColor = Colors.transparent.obs;
  final fillColor = AppColors.textFieldFillColor.obs;
  final textColor = AppColors.black.obs;

  final craditAmountBorderColor = Colors.transparent.obs;
  final craditAmountFillColor = AppColors.textFieldFillColor.obs;
  final craditAmountTextColor = AppColors.black.obs;

  Rx<DateTime?> selectedTransactionDate = Rx<DateTime?>(null);
  Rx<PaymentTypeModel> selectedPaymentType = AppConstants.paymentTypes.first.obs;
  TabController? tabController;

  static const double minInvestAmount = 100000;
  static const double maxInvestAmount = 250000;

  final tabs = [
    LocalizationKeys.moneyTransferEFTTextKey.tr,
    LocalizationKeys.creditCardTextKey.tr,
  ];
  RxList<InvestmentModelOld> get openInvestmentsOpportunities =>
      _projectService.openInvestmentsOpportunities;
  InvestmentModelOld? selectedProject;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    initializeTextFields();
    selectedProject = openInvestmentsOpportunities.first;
  }

  void initializeTextFields() {
    final account = selectedBankAccount.value;
    if (account != null) {
      ibanTextController.text = account.iban ?? '';
      recipientFullNameController.text = account.accountHolder ?? '';
      paymentTypeController.text = AppConstants.paymentTypes.first.title.tr;
      transactionDateController.text = Formatter.formatDateTime(DateTime.now());
    } else {
      paymentTypeController.text = AppConstants.paymentTypes.first.title.tr;
      transactionDateController.text = Formatter.formatDateTime(DateTime.now());
      ibanTextController.text = '';
      recipientFullNameController.text = '';
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      selectedTransactionDate.value = pickedDate;
      transactionDateController.text = Formatter.formatDateTime(pickedDate);
    }
  }

  void changeTab(int index) => selectedTabIndex.value = index;

  Future<void> selectPaymentType(BuildContext context) async {
    final paymentType = await Get.dropdownBottomSheet<PaymentTypeModel>(
        child: const BottomSheetSafeArea(
      child: PaymentTypeSelectionBottomSheetComp(),
    ));

    if (paymentType != null) {
      selectedPaymentType.value = paymentType;
      paymentTypeController.text = paymentType.title.tr;
    }
  }

  void useAllBalance() {
    final balance = selectedBankAccount.value?.availableBalance ?? 0;
    transactionAmountController.text = Formatter.formatMoney(balance, showCurrency: false);
    transactionAmount.value = balance;

    _updateTextFieldColors();
    _checkButtonEnableStatus();
  }

  double _getAmount() {
    final account = selectedBankAccount.value;
    if (account == null) return 0;

    switch (account.category) {
      case BankAccountCategory.mission:
        return investAmount.value;
      case BankAccountCategory.otherAccounts:
        return transactionAmount.value;
      default:
        return 0;
    }
  }

  bool _isWithinRange(double amount) => amount >= minInvestAmount && amount <= maxInvestAmount;

  void _updateTextFieldColors() {
    final amount = _getAmount();
    final isValid = _isWithinRange(amount) || amount == 0;

    borderColor.value = isValid ? AppColors.primaryColor : AppColors.primaryRedColor;
    fillColor.value =
        isValid ? AppColors.textFieldFillColor : AppColors.primaryRedColor.withOpacity(0.2);
    textColor.value = isValid ? AppColors.black : AppColors.primaryRedColor;
  }

  void onInvestAmountChanged(String value) {
    if (value.isEmpty) {
      investAmount.value = 0;
    } else {
      investAmount.value = Formatter.convertFormattedAmountStringToDouble(value);
    }
    _updateTextFieldColors();
    _checkButtonEnableStatus();
  }

  void onCradiCardInvestAmountChanged(String value) {
    if (value.isEmpty) {
      investAmount.value = 0;
    } else {
      investAmount.value = Formatter.convertFormattedAmountStringToDouble(value);
    }
    _updateCradiCardTextFieldColors();
    _checkCradiCardButtonEnableStatus();
  }

  void _updateCradiCardTextFieldColors() {
    final amount = investAmount.value;
    final isValid = amount >= minInvestAmount && amount <= maxInvestAmount;

    craditAmountBorderColor.value = isValid ? AppColors.primaryColor : AppColors.primaryRedColor;
    craditAmountFillColor.value =
        isValid ? AppColors.textFieldFillColor : AppColors.primaryRedColor.withOpacity(0.2);
    craditAmountTextColor.value = isValid ? AppColors.black : AppColors.primaryRedColor;
  }

  void _checkCradiCardButtonEnableStatus() {
    isButtonEnabled.value = isCampaignAccepted.value &&
        isRiskAccepted.value &&
        investAmount.value >= minInvestAmount &&
        investAmount.value <= maxInvestAmount;
  }

  void onTransactionAmountChanged(String value) {
    if (value.isEmpty) {
      transactionAmount.value = 0;
    } else {
      transactionAmount.value = Formatter.convertFormattedAmountStringToDouble(value);
    }
    _updateTextFieldColors();
    _checkButtonEnableStatus();
  }

  void _checkButtonEnableStatus() {
    final amount = _getAmount();
    isButtonEnabled.value =
        isCampaignAccepted.value && isRiskAccepted.value && _isWithinRange(amount);
  }

  void onCampaignAccepted(bool? value) {
    if (value != null) {
      isCampaignAccepted.value = value;
      _checkButtonEnableStatus();
    }
  }

  void onRiskAccepted(bool? value) {
    if (value != null) {
      isRiskAccepted.value = value;
      _checkButtonEnableStatus();
    }
  }

  bool get showInvestAmountError {
    final amount = selectedTabIndex.value == 0 ? _getAmount() : investAmount.value;
    return amount != 0 && !_isWithinRange(amount);
  }

  String? getInvestAmountErrorText() {
    final amount = selectedTabIndex.value == 0 ? _getAmount() : investAmount.value;

    if (amount != 0) {
      if (amount > maxInvestAmount) {
        return LocalizationKeys.maxInvestAmountErrorTextKey.tr;
      } else if (amount < minInvestAmount) {
        return LocalizationKeys.minInvestAmountErrorTextKey.tr;
      }
    }
    return null;
  }

  String getErrorWidgetInfoText() {
    if (_getAmount() > maxInvestAmount) {
      return LocalizationKeys.becomeQualifiedInvestorTextKey.tr;
    } else if (_getAmount() < minInvestAmount) {
      return LocalizationKeys.transferMoneyTextKey.tr;
    }
    return '';
  }

  Rx<BankAccountModel?> get selectedBankAccount => _bankAccountService.selectedAccount;
  Rx<BankModel?> get selectedBank => Get.find<BankService>().selectedBank;

  @override
  void onClose() {
    amountTextController.dispose();
    ibanTextController.dispose();
    recipientFullNameController.dispose();
    transactionAmountController.dispose();
    codeTextController.dispose();
    transactionDateController.dispose();
    paymentTypeController.dispose();
    tabController?.dispose();
    selectedBank.value = null;
    selectedBankAccount.value = null;
    super.onClose();
  }

  void increaseScale(double scale) {
    if (scale < 3.0) {
      scale += 0.1;
    }
  }

  void decreaseScale(double scale) {
    if (scale > 1.0) {
      scale -= 0.1;
    }
  }
}
