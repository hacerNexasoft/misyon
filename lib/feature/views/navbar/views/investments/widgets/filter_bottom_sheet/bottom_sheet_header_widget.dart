part of '../../investments_view.dart';

class _BottomSheetHeaderWidget extends BaseGetView<InvestmentsViewController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: ScaleFactorAutoSizeText(
        text: LocalizationKeys.filterChangeDisplayTextKey.tr,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
