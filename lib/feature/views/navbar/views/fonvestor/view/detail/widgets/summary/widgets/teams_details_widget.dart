import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class TeamsDetailsWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;
  final Color color;

  const TeamsDetailsWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.role,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomSheetSafeArea(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 10.sp),
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.w),
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(),
              SizedBox(height: 20.sp),
              _buildTeams(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      width: Get.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            child: const Icon(
              Icons.close,
              color: AppColors.darkTextColor,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeams() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w), // Resim ve metin arasına boşluk
              // Name ve Role alanları
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleFactorAutoSizeText(
                    text: name,
                    style: Get.theme.primaryTextTheme.titleMedium!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h), // Name ile Role arasında boşluk
                  ScaleFactorAutoSizeText(
                    text: role,
                    style: Get.theme.primaryTextTheme.bodyLarge!.copyWith(
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                  ScaleFactorAutoSizeText(
                    text: "",
                    style: Get.theme.primaryTextTheme.bodyLarge!.copyWith(
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/*
Lorem ipsum dolor sit amet consectetur adipiscing elit laoreet, phasellus condimentum parturient purus pulvinar feugiat curabitur nec diam, tincidunt morbi enim penatibus facilisis tellus posuere. Auctor risus integer congue bibendum suscipit sapien dictum montes ut aenean sociosqu viverra cras lacus cubilia, commodo laoreet velit et pharetra taciti magna dapibus habitasse venenatis phasellus molestie aliquet tempus. Eleifend pulvinar nullam cras augue mauris enim, cubilia habitant diam tortor nisi, per velit proin vulputate erat.

Donec ante habitasse placerat velit magnis erat fusce, nec platea nibh luctus dignissim facilisi non curae, sodales aptent iaculis ultrices sociis varius. Quam proin urna ornare per metus neque ante euismod, nulla semper quisque elementum volutpat orci convallis scelerisque, consequat non ac commodo suscipit malesuada platea. Ultrices proin facilisis orci fames faucibus, rhoncus sodales tristique netus, ullamcorper mauris dis vehicula.
 */
