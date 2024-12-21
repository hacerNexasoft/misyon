import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/explore/explore_view_controller.dart';

class ExploreViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExploreViewController());
  }
}
