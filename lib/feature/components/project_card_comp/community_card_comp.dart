import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/models/widget_models/community_item_model.dart';
import 'package:misyonbank/product/utils/extensions.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';

class CommunityCardComp extends BaseStatelessWidget {
  final CommunityItemModel communityItemModel;
  final VoidCallback? onTap;
  const CommunityCardComp({
    super.key,
    required this.communityItemModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _communityCard;
  }

  Widget get _communityCard => GestureDetector(
        onTap: () => Get.toNamed(
          AppRoutes.detailView,
          arguments: {
            'projectName': communityItemModel.projectName,
          },
        ),
        child: SizedBox(
          width: 343.w,
          child: Card(
            color: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 3,
            shadowColor: AppColors.borderGray.withOpacity(0.5),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _imageBox,
                  _textSection,
                  SizedBox(width: 10.w),
                  _amountAndLabelSection,
                ],
              ),
            ),
          ),
        ),
      );

  Widget get _imageBox => Container(
        padding: EdgeInsets.all(1.w),
        margin: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: ProjectCustomCachedNetworkImageComp(
          imageUrl: communityItemModel.imageUrl,
          size: 40.w,
          isCircular: true,
        ),
      );

  Widget get _textSection => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleFactorAutoSizeText(
            text: communityItemModel.projectName ?? '',
            style: theme.primaryTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          ScaleFactorAutoSizeText(
            text: communityItemModel.ceo ?? '',
            style: theme.primaryTextTheme.bodySmall
                ?.copyWith(color: AppColors.primaryGreyColor),
          ),
        ],
      );

  Widget get _amountAndLabelSection => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleFactorAutoSizeText(
                text: Formatter.formatMoney(communityItemModel.amount),
                maxLines: 1,
                style: theme.primaryTextTheme.bodyLarge),
            SizedBox(height: 5.h),
            Container(
              decoration: BoxDecoration(
                color: communityItemModel.investment?.getColorExploreInvestment,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
              child: ScaleFactorAutoSizeText(
                text: communityItemModel.investment?.getStringExploreInvestment,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodySmall?.copyWith(
                    color: communityItemModel
                        .investment?.getColorTextExploreInvestment,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
}
