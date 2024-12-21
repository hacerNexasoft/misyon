import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/teams_view_controller.dart';

class TeamsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamsViewController());
  }
}
