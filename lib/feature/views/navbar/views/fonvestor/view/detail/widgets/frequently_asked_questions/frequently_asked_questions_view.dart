import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/custom_detail_widget/custom_detail_widget.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/frequently_asked_questions_widget.dart';

class FrequentlyAskedQuestionsView extends BaseGetView<DetailViewController> {
  const FrequentlyAskedQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        children: [FrequentlyAskedQuestionsWidget()]);
  }
}
