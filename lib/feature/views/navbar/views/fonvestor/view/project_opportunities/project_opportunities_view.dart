import 'package:common/common.dart';
import 'package:misyonbank/feature/components/project_card_comp/project_card_comp.dart';
import 'package:misyonbank/feature/components/search_row_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/project_opportunities_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/views/investment_opportunities_view_filtering.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/views/search_view.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class ProjectOpportunitiesView extends BaseGetView<ProjectOpportunitiesController> {
  const ProjectOpportunitiesView({super.key});

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
                  //Filtreleme chipleri
                  buildSelectedProjectRange(),
                  buildSelectedPeriod(),
                  buildSelectedTerms(),
                  buildSelectedTags(),
                  buildSelectedSectors(),
                ],
              ),
            ),
          );
        },
      );

  Widget buildSelectedProjectRange() {
    if (controller.bottompress.value == true &&
        controller.selectedRateOfEarnRange.value.start > 10) {
      return _buildStatusItem(
        text:
            "%${controller.selectedRateOfEarnRange.value.start.toInt().toString()} - %${controller.selectedRateOfEarnRange.value.end.toInt().toString()}",
        closeOption: true,
        onClearTap: () {
          controller.onProjectRangeDelete(
            const RangeValues(0, 0),
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSelectedPeriod() {
    if (controller.bottompress.value == true && controller.selectedPeriod.value.isNotEmpty) {
      return _buildStatusItem(
        text: controller.selectedPeriod.value,
        closeOption: true,
        onClearTap: () {
          controller.selectedPeriod.value = '';
          controller.update();
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSelectedTerms() {
    if (controller.bottompress.value == true && controller.selectedTerm.value != 0) {
      return _buildStatusItem(
        text: "${controller.selectedTerm.value} Ay",
        closeOption: true,
        onClearTap: () {
          controller.selectedTerm.value = 0;
          controller.update();
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSelectedTags() {
    if (controller.bottompress.value == true && controller.selectedCities.isNotEmpty) {
      return _buildStatusItem(
        text: controller.selectedCities.join(', '),
        closeOption: true,
        onClearTap: () {
          controller.selectedCities.clear();
          controller.update();
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSelectedSectors() {
    if (controller.bottompress.value == true && controller.selectedCategories.isNotEmpty) {
      return _buildStatusItem(
        text: controller.selectedCategories.join(', '),
        closeOption: true,
        onClearTap: () {
          controller.selectedCategories.clear();
          controller.update();
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

  Widget get _buildCardList => Expanded(child: GetBuilder<ProjectOpportunitiesController>(
        builder: (c) {
          List<ProjectModel> filteredProjects = controller.filteredProjects;
          return ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredProjects.length,
            itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 15.w),
                child: ProjectCardComp(
                  image: filteredProjects.elementAt(index).coverImage,
                  projectModel: filteredProjects[index],
                )),
          );
        },
      ));

  // Arama çubuğu
  Widget get _searchBar => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: SearchRowComp(
            backIcon: true,
            leftIcon: AssetConstants.searchComp,
            rightIcon: AssetConstants.filterIcon,
            onLeftIconTap: () => controller.sortingShowBottomSheet(),
            onRightIconTap: () => Get.to(() => const ProjectOpportunitiesViewFiltering()),
            additionalFunction: () => Get.to(
              () => const SearchView(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 500),
            ),
          ),
        ),
      );
}
