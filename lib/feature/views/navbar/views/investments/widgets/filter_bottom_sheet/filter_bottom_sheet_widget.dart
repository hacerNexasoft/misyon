part of '../../investments_view.dart';

class _FilterBottomSheet extends BaseGetView<InvestmentsViewController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: BottomSheetSafeArea(
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BottomSheetHeaderWidget(),
              _FilterOptionsWidget(),
              _ApplyButtonWidget()
            ],
          ),
        ),
      ),
    );
  }
}
