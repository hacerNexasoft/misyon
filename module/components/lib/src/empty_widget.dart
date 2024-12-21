import 'package:common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgets/src/scale_factor_text.dart';

class EmptyWidget extends BaseStatelessWidget {
  final String image;
  final String text;
  final double size;
  const EmptyWidget(
      {super.key, required this.image, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            image,
            height: size,
            fit: BoxFit.contain,
            colorFilter:
                const ColorFilter.mode(AppColors.grey300Color, BlendMode.srcIn),
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        ScaleFactorText(
          text: text,
          style: theme.primaryTextTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.grey300Color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
