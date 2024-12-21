import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_controller.dart';

class DetailViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailViewController());
  }
}
