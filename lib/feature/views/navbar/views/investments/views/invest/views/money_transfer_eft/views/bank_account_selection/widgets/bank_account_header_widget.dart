part of '../../../../../invest_view.dart';

class _BankAccountHeaderWidget extends BaseGetView<InvestViewController> {
  final String? title;
  final String? subtitle;
  final String? imageUrl;
  const _BankAccountHeaderWidget(
      {required this.title, this.subtitle, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              _image,
              SizedBox(width: 20.w),
              _hederTitle,
            ],
          ),
        ),
        SvgPicture.asset(
          AssetConstants.arrowForwardIOSIcon,
          height: 12.w,
        ),
      ],
    );
  }

  Widget get _image => Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryPinkColor,
              width: 2,
            ),
            color: AppColors.secondaryPinkColor),
        child: ProjectCustomCachedNetworkImageComp(
          imageUrl: imageUrl,
          isCircular: true,
          size: 32.w,
          fit: BoxFit.contain,
        ),
      );

  Widget get _hederTitle => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleFactorAutoSizeText(
              text: title,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle != null && subtitle!.isNotEmpty)
              ScaleFactorAutoSizeText(
                text: subtitle,
                style: theme.primaryTextTheme.bodySmall?.copyWith(
                  color: AppColors.primaryGreyColor,
                ),
              ),
          ],
        ),
      );
}
