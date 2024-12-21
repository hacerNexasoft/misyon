import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/investment_opportunities_controller.dart';

class InvestmentOpportunitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InvestmentOpportunitiesController());
  }
}
