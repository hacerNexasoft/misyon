import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/explore/views/filter_communities/filter_communities_controller.dart';

class FilterCommunitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FilterCommunitiesController());
  }
}
