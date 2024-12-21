
import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:misyonbank/feature/views/navbar/navbar_view_controller.dart';
import 'package:misyonbank/product/localization/localization_service.dart';
import 'package:logger/logger.dart';
import 'package:misyonbank/product/services/bank_account_service.dart';
import 'package:misyonbank/product/services/bank_service.dart';
import 'package:misyonbank/product/services/investment_service.dart';
import 'package:misyonbank/product/services/project_service.dart';

class GetxManager {
  static Future<void> setupServices() async {
    Get.put(Dio(), permanent: true);
    Get.put(Logger(), permanent: true);
    Get.put(CacheService(), permanent: true);
    Get.put(ProjectService(), permanent: true);
    Get.put(InvestmentService(), permanent: true);
    Get.put(BankService(), permanent: true);
    Get.put(BankAccountService(), permanent: true);
    await Get.put(LocalizationService(), permanent: true).initLocale();
  }

  static Future<void> setupControllers() async {
    Get.put(NavbarViewController(), permanent: true);
  }

}