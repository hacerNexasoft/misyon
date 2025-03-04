import 'package:common/common.dart';
import 'package:intl/intl.dart';
import 'package:misyonbank/feature/components/cancel_comp/cancel_bottom_sheet_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/util/investment_list_filter.dart';
import 'package:misyonbank/product/constants/app_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/investment_models/investment_model.dart';
import 'package:misyonbank/product/models/payment_type_model.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/services/project_service.dart';
import 'package:misyonbank/product/utils/formatter.dart';

class TransactionsViewController extends BaseGetxController with GetTickerProviderStateMixin {
  final _projectService = Get.find<ProjectService>();
  final transactionStartDateController = TextEditingController();
  final transactionEndDateController = TextEditingController();
  Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);
  Rx<String> searchText = ''.obs;

  RxBool isDateRangePickerVisible = false.obs;
  var selectedIndex = 0.obs;
  var textPendingTransactions = [
    "Tutar vadesiz hesabınıza aktarılacaktır.",
    "%300 fonlama oranına ulaşıldı. Tarafınıza parçalı iade yapılacaktır."
  ];
  var showAllTags = false.obs;
  RxString selectedperiods = ''.obs; // Seçilen dönem
  RxList<String> selectedTags = <String>[].obs;
  RxList<String> selectedSectors = <String>[].obs;
  var bottompress = false.obs;
  var showAllSectors = false.obs;
  Rx<PaymentTypeModel> selectedPaymentType = AppConstants.paymentTypes.first.obs;

  final List<String> durations = [
    "Aylık",
    "3 Ay",
  ];
  final List<String> tags = ["Label", "Label", "Label"];
  final List<String> transactionLdirectionList = ["Alış", "Getiri"];

  final List<String> periods = [
    "Bugün",
    "Son 7 Gün",
    "Son 1 Ay",
    "Son 3 Ay",
    "Son 6 Ay",
    "Son 1 Yıl",
  ];

  List<String> get visibleTags => showAllTags.value ? tags : tags.take(9).toList();

  TabController? tabController;
  final List<String> tabs = [
    LocalizationKeys.performedTextKey.tr,
    LocalizationKeys.waitingTextKey.tr,
    LocalizationKeys.cancelledTransactionsTextKey.tr,
  ];

  RxList<InvestmentModel> get completedInvestmentsList => _projectService.completedInvestments;
  RxList<InvestmentModel> get waitingInvestmentsList => _projectService.waitingInvestments;
  RxList<InvestmentModel> get failedInvestmentsList => _projectService.failedInvestments;

  InvestmentListFilter? investmentListFilter;

  Future<void> initView({Function()? action}) async {
    try {
      change(state, status: RxStatus.loading());
      await _projectService.fetchInvestments();

      if (_projectService.allInvestments.isEmpty) {
        change(state, status: RxStatus.error("No investments!"));
        return;
      }
      change(state, status: RxStatus.success());
    } catch (e) {
      change(state, status: RxStatus.error(e.toString()));
      logger.e(e);
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    initView();
    super.onInit();
  }

  set setSearchText(String txt) {
    searchText.value = txt;
    update();
  }

  Map<String, List<InvestmentModel>> groupByDate(List<InvestmentModel> investments) {
    Map<String, List<InvestmentModel>> groupedInvestments = {};
    for (var investment in investments) {
      String dateKey = DateFormat('dd MMMM yyyy', 'tr_TR').format(investment.investmentDate);
      if (!groupedInvestments.containsKey(dateKey)) {
        groupedInvestments[dateKey] = [];
      }
      groupedInvestments[dateKey]?.add(investment);
    }
    return groupedInvestments;
  }

  ProjectModel? bringProjectModel(String projectId) {
    return _projectService.allProjectsList.firstWhereOrNull(
      (element) => element.id == projectId,
    );
  }

  Future<void> showBottomSheet() async {
    await Get.dropdownBottomSheet(
      child: CancelBottomSheetComp(
        title: "Yatırımı iptal etmek istediğine emin misin?",
        subtitle: "İptal ettiğinde yatırım tutarı Fonvestor hesabına iade edilecektir.",
        onApply: () {
          Get.back();
        },
      ),
    );
  }

  void resetMaturities() {
    selectedperiods.value = "";
  }

  // Seçilen sekme işlemi
  void onTabSelected(int index) {
    selectedIndex.value = index;
    update();
  }

  void resetAllSelected() {
    selectedperiods.value = '';
    selectedTags.value = [];
    selectedSectors.value = [];
    bottompress.value = false;
    transactionEndDateController.text = "";
    transactionStartDateController.text = "";
    investmentListFilter = null;
  }

  void selectMaturity(String maturity) {
    selectedperiods.value = maturity;
    isDateRangePickerVisible.value = false;
  }

  bool isMaturitySelected(String maturity) {
    return selectedperiods.value == maturity;
  }

  void toggleTagSelection(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  void onClickfilterButton() {
    bottompress.value = true;

    investmentListFilter = InvestmentListFilter(
        tags: selectedTags,
        selectedPeriod: selectedperiods.value,
        startDate: selectedStartDate.value,
        endDate: selectedEndDate.value);

    investmentListFilter!.applyFilter(
        completedInvestmentsList: completedInvestmentsList.toList(),
        waitingInvestmentsList: waitingInvestmentsList.toList(),
        failedInvestmentsList: failedInvestmentsList.toList());

    update();
  }

  void toggleDateRangePicker() {
    isDateRangePickerVisible.value = !isDateRangePickerVisible.value;
  }

  void selectDateRange() {
    selectedperiods.value = "Tarih Aralığı Seçin";
  }

  Future<void> selectStartDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      selectedStartDate.value = pickedDate;
      transactionStartDateController.text = Formatter.formatDateTime(pickedDate);
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      selectedEndDate.value = pickedDate;
      transactionEndDateController.text = Formatter.formatDateTime(pickedDate);
    }
  }
}
