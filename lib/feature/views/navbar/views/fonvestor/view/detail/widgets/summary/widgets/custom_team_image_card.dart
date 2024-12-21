import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:widgets/components.dart';

class CustomTeamImageCard extends BaseStatelessWidget {
  final String? name;
  final String? role;
  final String? imageUrl;
  final Color? color; // Arka plan rengi
  final VoidCallback? onTap; // Tıklama özelliği için callback

  const CustomTeamImageCard({
    super.key,
    this.name,
    this.role,
    this.imageUrl,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 165.w,
        height: 210.h,
        child: Stack(
          children: [
            // Renk arka plan olarak ekleniyor
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            // Resim katmanı
            if (imageUrl != null && imageUrl!.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            // Üst katman (gradient ve metinler)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withOpacity(0),
                    AppColors.black.withOpacity(0.83),
                  ],
                  stops: const [0.5, 0.86],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
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
      ),
    );
  }
}
