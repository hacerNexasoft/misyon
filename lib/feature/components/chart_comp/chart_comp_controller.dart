import 'package:common/common.dart';

class ChartCompController extends GetxController {
  var selectedIndex = 0.obs;
  var chartData = [
    AppColors.softwareColor,
    AppColors.marketingColor,
    AppColors.perfonelColor,
    AppColors.payoutColor,
    AppColors.otherColor
  ].obs;
}
