import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:misyonbank/feature/views/navbar/navbar_view_controller.dart';
import 'package:misyonbank/configs/service/api_service.dart';
import 'package:misyonbank/product/localization/localization_service.dart';
import 'package:logger/logger.dart';
import 'package:misyonbank/product/services/bank_account_service.dart';
import 'package:misyonbank/product/services/bank_service.dart';
import 'package:misyonbank/product/services/investment_service.dart';
import 'package:misyonbank/product/services/jwt_token_service.dart';
import 'package:misyonbank/product/services/project_service.dart';
import 'package:misyonbank/product/services/sign_in_service.dart';

import '../../configs/service/dio_client.dart';
import 'fetchers/projectdetail_fetcher_static_service.dart';

class GetxManager {
  static Future<void> setupServices() async {

    final dioClient = DioClient();
    final apiService = ApiService(dioClient);

    Get.put(Dio(), permanent: true);
    Get.put(Logger(), permanent: true);
    Get.put(CacheService(), permanent: true);
    Get.put(JwtTokenService());
    Get.put(ProjectService(), permanent: true);
    Get.put(SignInService());
    Get.put(InvestmentService(), permanent: true);
    Get.put(BankService(), permanent: true);
    Get.put(BankAccountService(), permanent: true);
    Get.put(FonvestorService(), permanent: true);
    Get.put(dioClient, permanent: true);
    Get.put(apiService, permanent: true);


    await Get.put(LocalizationService(), permanent: true).initLocale();
  }

  static Future<void> setupControllers() async {
    Get.put(NavbarViewController(), permanent: true);
  }
}
