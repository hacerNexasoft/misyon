import 'package:common/common.dart';

extension CustomExtensionBottomSheet on GetInterface {
  Future<T?> dropdownBottomSheet<T>({
    required Widget child,
  }) async {
    try {
      final result = await Get.bottomSheet<T>(
        child,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        enterBottomSheetDuration: const Duration(milliseconds: 400),
        clipBehavior: Clip.hardEdge,
        isScrollControlled: true,
        persistent: false,
        ignoreSafeArea: false,
      );
      return result;
    } catch (e) {
      debugPrint('Error in dropdownBottomSheet: $e');
      return null;
    }
  }

  Future showCustomSnackBar({
    required String title,
    required String message,
    required SnackBarType snackBarType,
  }) async {
    Get.snackbar(
      title,
      message,
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
      margin: EdgeInsets.symmetric(
          vertical: Get.height * 0.01, horizontal: Get.width * 0.01),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.grey900Color,
      colorText: AppColors.white,
      icon: Padding(
          padding: EdgeInsets.all(Get.width * 0.01),
          child: _getSnackBarIcon(snackBarType)),
    );
  }

  Icon _getSnackBarIcon(SnackBarType snackBarType) {
    switch (snackBarType) {
      case SnackBarType.success:
        return const Icon(Icons.check_circle, color: AppColors.paleGreenColor);
      case SnackBarType.error:
        return const Icon(Icons.info, color: AppColors.primaryRedColor);
      case SnackBarType.warning:
        return const Icon(Icons.warning, color: AppColors.primaryWarningColor);
    }
  }
}
