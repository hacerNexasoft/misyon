import 'package:common/common.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/investment_model_old.dart';
import 'package:misyonbank/product/services/project_service.dart';

class BuySellViewController extends BaseGetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  var tabs = [LocalizationKeys.buyTextKey.tr, LocalizationKeys.sellTextKey.tr];
  var selectedTabIndex = 0.obs;
  var selectedList = <InvestmentModelOld>[].obs;
  late final List<List<InvestmentModelOld>> lists;
  final _projectService = Get.find<ProjectService>();

  @override
  void onInit() async {
    await initView();
    super.onInit();
  }

  RxList<InvestmentModelOld> get getBuyProjects => _projectService.buyProjects;
  RxList<InvestmentModelOld?> get getSellProjects => _projectService.sellProjects;

  Future<void> initView({Function()? action}) async {
    try {
      change(state, status: RxStatus.loading());
      tabController = TabController(length: 2, vsync: this);
      //await _projectService.fetchBuyProjects();
      await _projectService.fetchSellProjects();
      lists = [getBuyProjects, []];
      selectedList.assignAll(getBuyProjects);
      change(state, status: RxStatus.success());
    } catch (e) {
      change(state, status: RxStatus.error(e.toString()));
      logger.e(e);
    }
  }

  void changeTab(int newIndex) async {
    try {
      change(state, status: RxStatus.loading());

      final newList = lists[newIndex];
      selectedList.assignAll(newList);
      if (selectedList.isEmpty) {
        change(state, status: RxStatus.empty());
      } else {
        change(state, status: RxStatus.success());
      }
    } catch (e) {
      change(state, status: RxStatus.error(e.toString()));
      logger.e(e);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
