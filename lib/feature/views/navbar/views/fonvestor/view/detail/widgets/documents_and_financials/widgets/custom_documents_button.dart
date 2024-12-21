import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/feature/components/pdf_viewer_from_url.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class CustomDocumentsButton extends BaseStatelessWidget {
  final String? title;

  const CustomDocumentsButton({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const PDFViewerFromUrl(
              url:
                  'https://www.ziraatbank.com.tr/tr/Forms/banka-kart-urun-bilgi-formu.pdf',
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
        decoration: BoxDecoration(
          color: AppColors.grey50Color,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Row(
          mainAxisSize:
              MainAxisSize.min, // Sadece içeriğin genişliği kadar yer kaplasın
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AssetConstants.downloadIcon,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 10.w),
            ScaleFactorAutoSizeText(
              textAlign: TextAlign.center,
              text: title ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
