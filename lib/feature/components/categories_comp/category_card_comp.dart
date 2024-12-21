import 'package:common/common.dart';
import 'package:misyonbank/product/models/category_model.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCardComp extends BaseStatelessWidget {
  final CategoryModel? category;
  const CategoryCardComp({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return category != null ? _cardContent : const SizedBox();
  }

  Widget get _cardContent => Container(
        width: 108.w,
        height: 108.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _backgroundImage,
            _title,
          ],
        ),
      );

  Widget get _title => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: ScaleFactorAutoSizeText(
          text: category?.name,
          style: theme.primaryTextTheme.labelSmall?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget get _backgroundImage => ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            CustomCachedNetworkImage(
              imageUrl: category?.imageUrl ?? '',
              fit: BoxFit.cover,
              height: 108.h,
              width: Get.width,
              placeholder: (context, url) => SkeletonAnimation(
                child: const SizedBox(),
              ),
              errorWidget: (context, url, error) => const ImageFailedToLoad(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      );
}
