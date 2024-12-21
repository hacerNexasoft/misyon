import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:widgets/components.dart';

class PeriodWidget extends BaseGetView<TransactionsViewController> {
  const PeriodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsViewController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 20.h),
            _buildMaturitiesOptions(),
            SizedBox(height: 20.h),
            _buildDateRangePicker(),
            SizedBox(height: 20.h),
            _buildDateRangeOptions(context)
          ],
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: "Dönem",
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget _buildMaturitiesOptions() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20.h,
        crossAxisSpacing: Get.width * 0.05,
        childAspectRatio: 2.5,
      ),
      itemCount: controller.periods.length,
      itemBuilder: (context, index) {
        return Obx(() {
          return GestureDetector(
            onTap: () {
              controller.selectMaturity(controller.periods[index]);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.isMaturitySelected(controller.periods[index])
                    ? AppColors.primaryColor
                    : AppColors.dividerColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ScaleFactorAutoSizeText(
                text: controller.periods[index],
                style: controller.isMaturitySelected(controller.periods[index])
                    ? theme.primaryTextTheme.bodyMedium
                        ?.copyWith(color: AppColors.backgroundColor)
                    : theme.primaryTextTheme.bodyMedium,
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildDateRangePicker() {
    return GestureDetector(
      onTap: () {
        controller.selectDateRange();
        controller.toggleDateRangePicker();
      },
      child: Obx(() {
        final isSelected = controller.isMaturitySelected("Tarih Aralığı Seçin");
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          height: 40.h,
          width: 200.w,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : AppColors.dividerColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: ScaleFactorAutoSizeText(
              text: "Tarih Aralığı Seçin",
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? AppColors.backgroundColor
                    : AppColors.darkTextColor,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDateRangeOptions(BuildContext context) {
    return Obx(() {
      if (!controller.isDateRangePickerVisible.value) {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            generateTextField(
              enabled: false,
              label: "Başlangıç Tarihi",
              textEditingController: controller.transactionStartDateController,
              onTap: () async => await controller.selectStartDate(context),
              suffix: SvgPicture.asset(
                AssetConstants.calendarIcon,
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            generateTextField(
              enabled: false,
              label: "Bitiş Tarihi",
              textEditingController: controller.transactionEndDateController,
              onTap: () async => await controller.selectEndDate(context),
              suffix: SvgPicture.asset(
                AssetConstants.calendarIcon,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget generateTextField({
    String label = '',
    String? hintText,
    TextEditingController? textEditingController,
    void Function(String)? onChanged,
    bool enabled = true,
    void Function()? onTap,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    Color? fillColor,
    Widget? suffix,
    Color? borderColor,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              suffix != null ? EdgeInsets.only(right: 40.w) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: fillColor ?? AppColors.textFieldFillColor,
            borderRadius: BorderRadius.circular(Get.width * .03),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
            ),
          ),
          child: suffix != null
              ? Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        filled: true,
                        textEditingController: textEditingController,
                        hintText: hintText,
                        onTap: onTap,
                        hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryGreyColor,
                        ),
                        label: label,
                        contentVerticalPadding: 0,
                        contentHorizontalPadding: 0,
                        maxLength: maxLength,
                        inputFormatters: inputFormatters,
                        enabled: enabled,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Get.width * .03),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.transparent,
                        style: theme.primaryTextTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                        ),
                        onChanged: onChanged,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    suffix,
                  ],
                )
              : CustomTextField(
                  filled: true,
                  textEditingController: textEditingController,
                  hintText: hintText,
                  hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryGreyColor,
                  ),
                  label: label,
                  contentVerticalPadding: 0,
                  contentHorizontalPadding: 0,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Get.width * .03),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: AppColors.textFieldFillColor,
                  style: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                  ),
                  onChanged: onChanged,
                  keyboardType: TextInputType.text,
                ),
        ),
      );
}
