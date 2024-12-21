import 'package:common/common.dart';

class BottomSheetSafeArea extends BaseStatelessWidget {
  final Widget child;
  final ScrollPhysics? physics;

  const BottomSheetSafeArea({
    super.key,
    required this.child,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(top: Get.width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Get.width * 0.01,
            width: Get.width * 0.1,
            decoration: BoxDecoration(
              color: AppColors.grey400Color,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: physics ?? const BouncingScrollPhysics(),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
