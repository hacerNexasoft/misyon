part of 'yield_calculator_tool_widget.dart';

class CustomYieldTextField extends BaseStatelessWidget {
  final String title;
  final TextEditingController textController;
  final String? type;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const CustomYieldTextField({
    super.key,
    required this.title,
    required this.textController,
    this.inputFormatters,
    this.maxLength,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(width: 1.0, color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 0.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ScaleFactorAutoSizeText(
                      text: title,
                      style: theme.primaryTextTheme.labelMedium!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CustomTextField(
                    contentVerticalPadding: 1,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    fillColor: AppColors.backgroundColor,
                    style: theme.primaryTextTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    textEditingController: textController,
                    inputFormatters: inputFormatters,
                    maxLength: maxLength,
                    onChanged: (value) {
                      final formattedValue =
                          Formatter.formatMoney(value, zeroCount: 2);
                      textController.value = textController.value.copyWith(
                        text: formattedValue,
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: formattedValue.length),
                        ),
                      );
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ),
            ),
            if (type != null)
              Row(
                children: [
                  Container(
                    width: 2.w,
                    height: 30.h,
                    color: AppColors.borderGray,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ScaleFactorAutoSizeText(
                      text: type!,
                      style: theme.primaryTextTheme.bodyMedium!.copyWith(
                        color: AppColors.cardColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
