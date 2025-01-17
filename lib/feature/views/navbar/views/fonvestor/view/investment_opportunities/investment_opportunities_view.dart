import 'package:common/common.dart';
import 'package:misyonbank/feature/components/investment_card_comp/investment_card_comp.dart';
import 'package:misyonbank/feature/components/search_row_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/investment_opportunities_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/views/investment_opportunities_view_filtering.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/views/search_view.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class InvestmentOpportunitiesView
    extends BaseGetView<InvestmentOpportunitiesController> {
  const InvestmentOpportunitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            _searchBar,
            _buildSelectedStatus,
            _buildCardList,
          ],
        ),
      ),
    );
  }

  Widget get _buildSelectedStatus => Obx(
        () {
          return Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 50.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildStatusItem(
                    text: controller.selectedStatus.value.description,
                    onTap: () => controller.showBottomSheet(),
                    closeOption: false,
                  ),
                  buildSelectedInvestmentRange(),
                  buildSelectedDuration(),
                  buildSelectedMaturities(),
                  buildSelectedTags(),
                  buildSelectedSectors(),
                ],
              ),
            ),
          );
        },
      );

  Widget buildSelectedInvestmentRange() {
    if (controller.bottompress.value == true &&
        controller.selectedInvestmentRange.value.start > 10) {
      return _buildStatusItem(
        text:
            "%${controller.selectedInvestmentRange.value.start.toInt().toString()}",
        closeOption: true,
        onClearTap: () {
          controller.onInvestmentRangeDelete(
            RangeValues(10, controller.selectedInvestmentRange.value.start),
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSelectedDuration() {
    if (controller.bottompress.value == true &&
        controller.selectedDuration.value.isNotEmpty) {
      return _buildStatusItem(
        text: controller.selectedDuration.value,
        closeOption: true,
        onClearTap: () {
          controller.selectedDuration.value = '';
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSelectedMaturities() {
    if (controller.bottompress.value == true &&
        controller.selectedMaturities.value.isNotEmpty) {
      return _buildStatusItem(
        text: controller.selectedMaturities.value,
        closeOption: true,
        onClearTap: () {
          controller.selectedMaturities.value = '';
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSelectedTags() {
    if (controller.bottompress.value == true &&
        controller.selectedTags.isNotEmpty) {
      return _buildStatusItem(
        text: controller.selectedTags.join(', '),
        closeOption: true,
        onClearTap: () {
          controller.selectedTags.clear();
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSelectedSectors() {
    if (controller.bottompress.value == true &&
        controller.selectedSectors.isNotEmpty) {
      return _buildStatusItem(
        text: controller.selectedSectors.join(', '),
        closeOption: true,
        onClearTap: () {
          controller.selectedSectors.clear();
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildStatusItem({
    required String text,
    VoidCallback? onTap,
    required bool closeOption,
    VoidCallback? onClearTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.w),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(Get.width),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleFactorAutoSizeText(
              text: text,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: AppColors.backgroundColor,
              ),
            ),
            SizedBox(width: 10.w),
            if (closeOption)
              GestureDetector(
                onTap: onClearTap,
                child: Icon(
                  Icons.clear_rounded,
                  color: AppColors.backgroundColor,
                  size: 12.sp,
                ),
              )
            else
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.backgroundColor,
                size: 15.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget get _buildCardList => Expanded(
        child: Obx(
          () => ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.filteredProjects.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 15.w),
              child: controller.filteredProjects[index] != null
                  ? InvestmentCardComp(
                      infoText:
                          'Son ${controller.filteredProjects.elementAt(index)?.term.toString()} Gün',
                      image: controller.filteredProjects
                          .elementAt(index)!
                          .backimage
                          .toString(),
                      projectModel: controller.filteredProjects[index]!,
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      );

  // Arama çubuğu
  Widget get _searchBar => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: SearchRowComp(
            backIcon: true,
            leftIcon: AssetConstants.searchComp,
            rightIcon: AssetConstants.filterIcon,
            onLeftIconTap: () => controller.sortingShowBottomSheet(),
            onRightIconTap: () =>
                Get.to(const InvestmentOpportunitiesViewFiltering()),
            additionalFunction: () => Get.to(
              const SearchView(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 600),
            ),
          ),
        ),
      );
}
