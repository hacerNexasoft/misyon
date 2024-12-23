import 'package:common/common.dart';
import 'package:misyonbank/feature/components/cancel_comp/cancel_bottom_sheet_comp.dart';
import 'package:misyonbank/product/constants/app_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/payment_type_model.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:misyonbank/product/services/project_service.dart';
import 'package:misyonbank/product/utils/formatter.dart';

class TransactionsViewController extends BaseGetxController
    with GetTickerProviderStateMixin {
  final _projectService = Get.find<ProjectService>();
  final transactionStartDateController = TextEditingController();
  final transactionEndDateController = TextEditingController();
  Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);

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
  Rx<PaymentTypeModel> selectedPaymentType =
      AppConstants.paymentTypes.first.obs;

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

  List<String> get visibleTags =>
      showAllTags.value ? tags : tags.take(9).toList();

  TabController? tabController;
  final List<String> tabs = [
    LocalizationKeys.performedTextKey.tr,
    LocalizationKeys.waitingTextKey.tr,
    LocalizationKeys.cancelledTransactionsTextKey.tr,
  ];

  // Tarih aralığına göre gruplama
  Map<String, List<ProjectModel>> groupByDate(List<ProjectModel> transactions) {
    Map<String, List<ProjectModel>> groupedTransactions = {};
    for (var transaction in transactions) {
      final date = transaction.startDate ?? '';
      if (!groupedTransactions.containsKey(date)) {
        groupedTransactions[date] = [];
      }
      groupedTransactions[date]?.add(transaction);
    }
    return groupedTransactions;
  }

  RxList<ProjectModel?> get realizedTransactionList =>
      _projectService.realizedTransactionList;
  RxList<ProjectModel?> get pendingTransactionList =>
      _projectService.pendingTransactionList;
  RxList<ProjectModel?> get canceldTransactionList =>
      _projectService.canceldTransactionList;

  Future<void> initView({Function()? action}) async {
    try {
      change(state, status: RxStatus.loading());
      await _projectService.fetchRealizedTransactionList();
      await _projectService.fetchpendingTransactionList();
      await _projectService.fetchcanceldTransactionList();

      if (realizedTransactionList.isEmpty) {
        change(state, status: RxStatus.error(""));
        return;
      }
      if (pendingTransactionList.isEmpty) {
        change(state, status: RxStatus.error(""));
        return;
      }
      change(state, status: RxStatus.success());
    } catch (e) {
      change(state, status: RxStatus.error(e.toString()));
      logger.e(e);
    }
  }

  Future<void> showBottomSheet() async {
    await Get.dropdownBottomSheet(
      child: CancelBottomSheetComp(
        title: "Yatırımı iptal etmek istediğine emin misin?",
        subtitle:
            "İptal ettiğinde yatırım tutarı Fonvestor hesabına iade edilecektir.",
        onApply: () {
          Get.back();
        },
      ),
    );
  }

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    initView();
    super.onInit();
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

  void filteredBottomPress() {
    bottompress.value = true;
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
      transactionStartDateController.text =
          Formatter.formatDateTime(pickedDate);
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
