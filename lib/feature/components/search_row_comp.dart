import 'package:common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/components/search/search_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view_controller.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';

class SearchRowComp extends BaseGetView<TransactionsViewController> {
  final String? leftIcon;
  final String? rightIcon;
  final bool? backIcon;
  final bool giveUp; // Boolean değişkeni
  final Function()? onLeftIconTap;
  final Function()? onRightIconTap;
  final Function()? additionalFunction;
  final TextEditingController? textEditingController;

  const SearchRowComp({
    super.key,
    this.leftIcon,
    this.rightIcon,
    this.backIcon = false,
    this.giveUp = false,
    this.onLeftIconTap,
    this.onRightIconTap,
    this.additionalFunction,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (backIcon != false) _buildBackIcon(),
        Expanded(
          child: additionalFunction == null
              ? SearchComp(
                  hintText: LocalizationKeys.searchfecTextKey.tr,
                  onChanged: (txt) {
                    if (txt.length >= 2) {
                      controller.setSearchText = txt;
                    } else {
                      controller.setSearchText = '';
                    }
                  },
                )
              : _buildSearchContainer(),
        ),
        SizedBox(width: 10.sp),
        if (giveUp) _buildGiveUpText(),
        if (!giveUp) _buildIcons(),
      ],
    );
  }

  Widget _buildBackIcon() {
    return GestureDetector(
      onTap: Get.back,
      child: Padding(
        padding: EdgeInsets.only(right: 10.sp),
        child: Icon(
          Icons.arrow_back_rounded,
          color: AppColors.hintColor,
          size: 23.sp,
        ),
      ),
    );
  }

  Widget _buildSearchContainer() {
    return GestureDetector(
      onTap: () {
        additionalFunction!();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.textFieldFillColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.symmetric(vertical: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.w),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: SvgPicture.asset(
                AssetConstants.searchIcon,
                colorFilter: const ColorFilter.mode(AppColors.darkGreyColor, BlendMode.srcIn),
              ),
            ),
            SizedBox(width: 10.w),
            ScaleFactorAutoSizeText(
              text: 'Son yatırımlardan ara',
              style: theme.primaryTextTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiveUpText() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: ScaleFactorAutoSizeText(
        text: 'Vazgeç',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.primaryTextTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildIcons() {
    return Row(
      children: [
        if (leftIcon != null)
          GestureDetector(
            onTap: onLeftIconTap,
            child: SvgPicture.asset(leftIcon!),
          ),
        if (rightIcon != null) ...[
          GestureDetector(
            onTap: () {
              if (onRightIconTap != null) {
                onRightIconTap!();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: (leftIcon != null ? 20 : 0).w),
              child: SvgPicture.asset(rightIcon!),
            ),
          ),
        ]
      ],
    );
  }
}
