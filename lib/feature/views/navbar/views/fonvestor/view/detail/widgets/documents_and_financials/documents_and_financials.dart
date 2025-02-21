import 'package:common/common.dart';
import 'package:misyonbank/feature/components/chart_comp/chart_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/documents_and_financials/widgets/custom_documents_button.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/documents_and_financials/widgets/custom_income_widget.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/chart_data_model.dart';
import 'package:misyonbank/product/models/project/project_finansial_model.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/detail_platform_documents.widget.dart';
part 'widgets/fund_utilization_widget.dart';
part 'widgets/income_statement_widget.dart';
part 'widgets/balance_sheet_widget.dart';

class DocumentsAndFinancialsView extends BaseGetView<DetailViewController> {
  const DocumentsAndFinancialsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        shrinkWrap: true,
        children: [
          DetailPlatformDocumentsWidget(),
          SizedBox(
            height: 15.h,
          ),
          FundUtilizationWidget(),
          SizedBox(
            height: 15.h,
          ),
          IncomeStatementWidget(),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 15.h,
          ),
        ]);
  }
}
