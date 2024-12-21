import 'package:common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgets/components.dart';

class CustomErrorWidget extends BaseStatelessWidget {
  final String text;
  final double? size;
  final bool showImage;
  final Future<void> Function()? onRetry;
  final int? buttonPadding;
  final String? buttonText;
  final String? image;
  const CustomErrorWidget(
      {super.key,
      required this.text,
      this.size,
      this.onRetry,
      this.buttonPadding,
      this.buttonText,
      this.image,
      this.showImage = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.011),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImage(),
          ScaleFactorText(
            text: text,
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.hintColor,
            ),
            textAlign: TextAlign.center,
          ),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildButton() => onRetry != null
      ? Column(
          children: [
            SizedBox(height: Get.height * 0.01),
            Padding(
              padding: buttonPadding != null
                  ? EdgeInsets.symmetric(horizontal: buttonPadding!.toDouble())
                  : EdgeInsets.zero,
              child: CustomButton(
                onTap: onRetry,
                child: ScaleFactorAutoSizeText(
                  text: buttonText ?? 'Yeniden Dene',
                  style: theme.primaryTextTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )
      : const SizedBox();

  Widget _buildImage() {
    if (showImage && size != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              image ?? '',
              height: size,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: Get.height * 0.01),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
