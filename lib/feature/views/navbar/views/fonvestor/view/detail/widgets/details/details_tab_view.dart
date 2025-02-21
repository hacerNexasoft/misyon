import 'package:common/common.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/details/widgets/custom_company_detail_widget.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/company_detail_widget.dart';
part 'widgets/companytext_detail_widget.dart';

class DetailsTabView extends BaseGetView<DetailViewController> {
  const DetailsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        shrinkWrap: true,
        children: [
          CompanyDetailWidget(),
          SizedBox(
            height: 15.h,
          ),
          CompanytextDetailWidget()
        ]);
  }
}
