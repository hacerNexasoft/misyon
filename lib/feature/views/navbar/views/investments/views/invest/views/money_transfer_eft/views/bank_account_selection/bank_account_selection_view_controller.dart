import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/invest_view_controller.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/bank_account_model.dart';
import 'package:misyonbank/product/models/bank_model.dart';
import 'package:misyonbank/product/services/bank_account_service.dart';
import 'package:misyonbank/product/services/bank_service.dart';

class BankAccountSelectionViewController extends BaseGetxController
    with GetTickerProviderStateMixin {
  final _bankAccountService = Get.find<BankAccountService>();
  final _bankService = Get.find<BankService>();
  final missionAccounts = <BankAccountModel?>[].obs;
  final otherAccounts = <BankAccountModel?>[].obs;
  final bankInstitutionAccounts = <BankAccountModel?>[].obs;

  var filteredBankList = <BankModel?>[].obs;

  RxList<List<BankAccountModel?>> get accounts =>
      [missionAccounts, otherAccounts, bankInstitutionAccounts].obs;

  TabController? tabController;
  var selectedTabIndex = 0.obs;
  var accountSelectionTabs = [
    LocalizationKeys.missionTextKey.tr,
    LocalizationKeys.myOtherAccountsTextKey.tr,
    LocalizationKeys.bankInstitutionTextKey.tr,
  ];

  var filteredBankAccounts = <BankAccountModel>[].obs;

  @override
  void onInit() async {
    await init();
    super.onInit();
  }

  void onTabChanged(int index) => selectedTabIndex.value = index;

  void filterBankAccountsByCategory() {
    missionAccounts.clear();
    otherAccounts.clear();
    bankInstitutionAccounts.clear();
    for (var account in getAllBankAccounts) {
      switch (account?.category) {
        case BankAccountCategory.mission:
          missionAccounts.add(account);
          break;
        case BankAccountCategory.otherAccounts:
          otherAccounts.add(account);
          break;
        case BankAccountCategory.bankInstitution:
          bankInstitutionAccounts.add(account);
          break;
        default:
          break;
      }
    }
  }

  Future<void> init() async {
    try {
      change(state, status: RxStatus.loading());
      tabController = TabController(length: accountSelectionTabs.length, vsync: this);
      await _bankAccountService.fetchBankAccounts();
      await _bankService.fetchBanks();
      filteredBankList.assignAll(getAllBanks);
      if (getAllBankAccounts.isEmpty) {
        change(state, status: RxStatus.empty());
      } else {
        filterBankAccountsByCategory();
        change(state, status: RxStatus.success());
      }
    } catch (e) {
      logger.e(e);
      change(state, status: RxStatus.error(e.toString()));
    }
  }

  void changeSelectedBankAccount(BankAccountModel? account) {
    _bankService.changeSelectedBank(null);
    _bankAccountService.changeSelectedAccount(account);
    Get.find<InvestViewController>().initializeTextFields();
    Get.back();
  }

  void changeSelectedBank(BankModel? bank) {
    _bankAccountService.changeSelectedAccount(null);
    _bankService.changeSelectedBank(bank);
    Get.back();
  }

  void filterBanks(String query) {
    if (query.isNotEmpty) {
      filteredBankList.value = getAllBanks
          .where((bank) => bank?.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();

      if (filteredBankList.isEmpty) {
        change(state, status: RxStatus.empty());
      } else {
        change(state, status: RxStatus.success());
      }
    } else {
      filteredBankList.assignAll(getAllBanks);
      change(state, status: RxStatus.success());
    }
  }

  RxList<BankAccountModel?> get getAllBankAccounts => _bankAccountService.bankAccounts;
  RxList<BankModel?> get getAllBanks => _bankService.bankList;
}
