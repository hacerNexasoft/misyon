import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/project_opportunities_controller.dart';

class ProjectOpportunitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProjectOpportunitiesController());
  }
}
