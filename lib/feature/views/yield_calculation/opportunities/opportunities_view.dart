import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/components/investment_card_comp/investment_card_comp.dart';
import 'package:misyonbank/feature/views/yield_calculation/yield_calculation_view_controller.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:widgets/components.dart';

class OpportunitiesView extends BaseGetView<YieldCalculationViewController> {
  const OpportunitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildList(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
      title: ScaleFactorAutoSizeText(
        text: "Fırsatlar",
        style: theme.primaryTextTheme.bodyLarge?.semibold,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: const Icon(
              Icons.clear,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList() {
    return SizedBox(
      height: Get.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.filteredProjects.length,
        itemBuilder: (context, index) {
          var project = controller.filteredProjects[index];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
            child: InvestmentCardComp(
              infoText: 'Son ${project.term.toString()} Gün',
              image: project.backimage.toString(),
              projectModel: project,
            ),
          );
        },
      ),
    );
  }
}
