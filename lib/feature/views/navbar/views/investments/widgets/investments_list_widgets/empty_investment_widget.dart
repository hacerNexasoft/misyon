part of '../../investments_view.dart';

class _EmptyInvestmentWidget extends BaseStatelessWidget {
  final String icon;
  final String text;

  const _EmptyInvestmentWidget({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 10.h),
        _buildContent(),
        _buildButton,
      ],
    );
  }

  Widget _buildContent() {
    return SizedBox(
      height: 158.h,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIcon(),
          SizedBox(height: 12.h),
          _buildTitle(LocalizationKeys.readyToInvestTextKey.tr),
          SizedBox(height: 8.h),
          _buildDescription(LocalizationKeys.startInvestingTextKey.tr),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          AssetConstants.portfolioIcon,
          fit: BoxFit.contain,
          colorFilter: const ColorFilter.mode(
            AppColors.checkboxBorderColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return ScaleFactorAutoSizeText(
      text: text,
      style: theme.primaryTextTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(String text) {
    return ScaleFactorAutoSizeText(
      text: text,
      style: theme.primaryTextTheme.bodyMedium!,
      textAlign: TextAlign.center,
    );
  }

  Widget get _buildButton => Padding(
        padding: EdgeInsets.symmetric(vertical: 20.w),
        child: CustomButton(
          borderRadius: Get.width * .08,
          onTap: () {},
          child: ScaleFactorAutoSizeText(
            text: LocalizationKeys.seeOpportunitiesTextKey.tr,
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      );
}
