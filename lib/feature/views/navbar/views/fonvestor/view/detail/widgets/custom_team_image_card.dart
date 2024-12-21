import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:widgets/components.dart';

class CustomTeamImageCard extends BaseStatelessWidget {
  final String? name;
  final String? role;
  final String? imageUrl;

  const CustomTeamImageCard({
    super.key,
    this.name,
    this.role,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440.w,
      height: 300.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Get.height * 0.01),
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? ''),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Get.height * 0.01),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.black.withOpacity(0),
                  AppColors.black.withOpacity(1),
                ],
                stops: const [0, 0.86],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ScaleFactorAutoSizeText(
                  text: name,
                  style: theme.primaryTextTheme.bodySmall!.semibold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                ScaleFactorAutoSizeText(
                  text: role,
                  style: theme.primaryTextTheme.bodySmall!.semibold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
