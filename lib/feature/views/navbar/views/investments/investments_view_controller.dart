import 'package:common/common.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/widget_models/investments_item_model.dart';
import 'package:misyonbank/product/services/project_service.dart';
import 'package:misyonbank/product/utils/formatter.dart';

class InvestmentsViewController extends BaseGetxController
    with GetTickerProviderStateMixin {
  final _projectService = Get.find<ProjectService>();
  RxList<InvestmentsItemModel?> get investmentsItemList =>
      _projectService.investmentsItemList;
  final _selectedOption = LocalizationKeys.allTextslowerKey.tr.obs;
  var selectedInvestment = Rxn<InvestmentsItemModel>();
  var isExpanded = false.obs;
  var isTapped = false.obs;
  var explanationText =
      "Ödemen gecikmededir. İşlemlerden ödeme durumunu takip edebilirsin.";
  var yieldAmountPaid = 500.00;
  var expectedReturnAmount = 4500.00;
  final _filterOptions = [
    LocalizationKeys.allTextslowerKey.tr,
    LocalizationKeys.openInvestmentTextKey.tr,
    LocalizationKeys.atTerminationTextKey.tr,
    LocalizationKeys.returnPeriodTextKey.tr
  ];
  final _investmentBottomSheetDetailItemList = [
    "Toplam Yatırım Tutarı",
    "Güncel Kazancın",
    "Bekleyen Kazancın",
    "Toplam Bekleyen Kazancın",
  ];

  get selectedOption => _selectedOption;
  get filterOptions => _filterOptions;
  get investmentBottomSheetDetailItemList =>
      _investmentBottomSheetDetailItemList;

  @override
  void onInit() async {
    await initView();
    super.onInit();
  }

  MapEntry<String, Color> getInvestmentDetail(
      InvestmentsItemModel investment, String detailTitle) {
    switch (detailTitle) {
      case 'Toplam Yatırım Tutarı':
        return MapEntry(Formatter.formatMoney(investment.totalInvestmentAmount),
            AppColors.darkTextColor);

      case 'Güncel Kazancın':
        return MapEntry(Formatter.formatMoney(investment.currentEarnings),
            AppColors.primaryGreenColor);

      case 'Bekleyen Kazancın':
        return MapEntry("+${Formatter.formatMoney(investment.pendingEarnings)}",
            AppColors.purpleColorText);

      case 'Toplam Bekleyen Kazancın':
        return MapEntry(
            "+${Formatter.formatMoney(investment.totalPendingEarnings)}",
            AppColors.purpleColorText);

      default:
        return const MapEntry('', AppColors.black);
    }
  }

  Future<void> initView({Function()? action}) async {
    try {
      change(state, status: RxStatus.loading());
      await _projectService.fetchMyInvestments();

      if (investmentsItemList.isEmpty) {
        change(state, status: RxStatus.error(""));
        return;
      }
      if (investmentsItemList.isEmpty) {
        change(state, status: RxStatus.error(""));
        return;
      }
      change(state, status: RxStatus.success());
    } catch (e) {
      change(state, status: RxStatus.error(e.toString()));
      logger.e(e);
    }
  }

  void selectInvestment(InvestmentsItemModel investment) {
    selectedInvestment.value = investment;
  }
}
