import 'package:common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:widgets/components.dart';

class PopularSectors extends BaseStatelessWidget {
  final String iconPath;
  final String title;
  final List<String> items;

  const PopularSectors({
    super.key,
    required this.iconPath,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24.sp,
                height: 24.sp,
              ),
              SizedBox(width: 20.w),
              ScaleFactorAutoSizeText(
                text: title,
                style: theme.primaryTextTheme.bodyMedium!.medium.bold.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.sp),
        Container(
          color: AppColors.grey100Color,
          height: 1,
          width: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: Get.width * 0.02,
              childAspectRatio: 3,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1, color: AppColors.primaryGreyColor)),
                child: ScaleFactorAutoSizeText(
                  text: items[index],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.primaryTextTheme.bodyMedium?.semibold
                      .copyWith(color: AppColors.black),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
