import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/custom_detail_widget/custom_detail_widget_controller.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';

class CustomDetailWidget extends BaseStatelessWidget {
  final String? tag;
  final String? title;
  final Widget? child;
  final bool showBorder;

  const CustomDetailWidget({
    this.tag,
    super.key,
    this.title,
    this.child,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CustomDetailWidgetController(),
      tag: tag,
    );
    return GestureDetector(
      child: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        child: _buildDetail(controller),
      ),
    );
  }

  Widget _buildDetail(controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScaleFactorAutoSizeText(
                text: title,
                style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
                  color: AppColors.black,
                ),
              ),
              SizedBox(width: 10.w),
              Obx(() => IconButton(
                    icon: SvgPicture.asset(
                      controller.isExpanded.value
                          ? AssetConstants.upIcon
                          : AssetConstants.downIcon,
                      colorFilter: const ColorFilter.mode(
                        AppColors.hintColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: controller.toggleExpand,
                  )),
            ],
          ),
          Obx(
            () => controller.isExpanded.value
                ? Column(
                    children: [
                      child ??
                          EmptyWidget(
                            image: AssetConstants.emptyItemIcon,
                            text: LocalizationKeys.emptySearchTextKey.tr,
                            size: 24.h,
                          ),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      );
}
