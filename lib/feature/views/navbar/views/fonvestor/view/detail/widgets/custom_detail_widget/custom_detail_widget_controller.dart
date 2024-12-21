import 'package:common/common.dart';

class CustomDetailWidgetController extends BaseGetxController {
  var isExpanded = true.obs;
  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }
}
