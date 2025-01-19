import 'package:common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/utils/model_helpers.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/utils/extensions.dart';
part 'components/content_info_comp.dart';

class ProjectCardComp extends BaseStatelessWidget {
  final String infoText;
  final String image;
  final ProjectModel projectModel;
  const ProjectCardComp({
    super.key,
    required this.infoText,
    required this.image,
    required this.projectModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      height: (projectModel.status == ProjectStatus.activeFunding)
          ? 200.sp
          : 250.sp,
      child: Stack(
        children: [
          if (projectModel.status != ProjectStatus.unknown) ...[
            _backgroundImage,
            _cardContent,
          ]
        ],
      ),
    );
  }

  Widget get _cardContent => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _contentHeader,
            const Spacer(),
            _ContentInfoComp(projectModel: projectModel),
          ],
        ),
      );

  Widget get _contentHeader => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (infoText.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              decoration: BoxDecoration(
                /*color:
                  projectModel.status.getBackgroundColor(projectModel.maturity),*/ // Artık olmayan bir parametre sebebiyle iptal
                borderRadius: BorderRadius.circular(999.r),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline,
                      color: AppColors.backgroundColor),
                  SizedBox(width: 5.w),
                  ScaleFactorAutoSizeText(
                    text: infoText,
                    style: theme.primaryTextTheme.bodyMedium
                        ?.copyWith(color: AppColors.lightTextColor),
                  ),
                ],
              ),
            ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              AssetConstants.borderedStarIcon,
              width: 24.w,
            ),
          ),
        ],
      );

  Widget get _backgroundImage => ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            CustomCachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              width: Get.width,
              height: Get.width,
              placeholder: (context, url) => SkeletonAnimation(
                child: const SizedBox(),
              ),
              errorWidget: (context, url, error) => const ImageFailedToLoad(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withOpacity(0.5),
                    AppColors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
