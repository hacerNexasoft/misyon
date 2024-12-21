import 'package:common/common.dart';

class ImageFailedToLoad extends BaseStatelessWidget {
  final Color? backgroundColor;
  final int horizontalMargin;
  const ImageFailedToLoad(
      {super.key, this.backgroundColor, this.horizontalMargin = 40});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin.toDouble()),
      alignment: Alignment.center,
      height: Get.height * 0.02,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryGreyColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(Get.width * 0.03),
      ),
      child: Icon(
        Icons.image,
        size: Get.height * 0.01,
        color: AppColors.primaryGreyColor,
      ),
    );
  }
}
