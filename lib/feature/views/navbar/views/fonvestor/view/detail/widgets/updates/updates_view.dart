import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/updates/widgets/custom_updates_widget.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/updates_widget.dart';

class UpdatesView extends BaseGetView<DetailViewController> {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        shrinkWrap: true,
        children: [
          UpdatesWidget(),
        ]);
  }
}
