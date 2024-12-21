import 'dart:ui';

import 'package:common/common.dart';
import 'package:widgets/components.dart';

class ChainedImages extends BaseStatelessWidget {
  final List<String> imageUrls;
  final double? size;

  const ChainedImages({
    super.key,
    required this.imageUrls,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        return Transform.translate(
          offset: Offset((-10 * index).toDouble(), 0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: index < 3
                ? ProjectCustomCachedNetworkImageComp(
                    imageUrl: imageUrls[index],
                    size: size ?? Get.width * 0.03,
                  )
                : imageUrls.length > 3
                    ? Container(
                        width: size ?? Get.width * 0.03,
                        height: size ?? Get.width * 0.03,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              (size ?? Get.width * 0.03) / 2),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: EdgeInsets.all(Get.width * 0.001),
                              color: Colors.white.withOpacity(0.5),
                              child: Center(
                                child: ScaleFactorAutoSizeText(
                                  text: '+${imageUrls.length - 3}',
                                  style: theme.primaryTextTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
          ),
        );
      }),
    );
  }
}
