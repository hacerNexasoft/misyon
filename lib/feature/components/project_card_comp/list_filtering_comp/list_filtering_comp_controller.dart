import 'package:common/common.dart';

class ListFilteringCompController<T> extends BaseGetxController {
  final Rx<T?> selectedStatus;

  ListFilteringCompController(T? initialStatus)
      : selectedStatus = Rx<T?>(initialStatus);

  void onSelectStatus(T newStatus) {
    selectedStatus.value = newStatus;
    update();
  }
}
