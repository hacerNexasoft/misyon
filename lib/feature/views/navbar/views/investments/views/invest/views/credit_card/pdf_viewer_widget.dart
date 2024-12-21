import 'package:common/common.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/invest_view_controller.dart';

import 'package:widgets/components.dart';

class PdfViewerWidget extends BaseGetView<InvestViewController> {
  final String title;
  final String pdfUrl;
  final RxBool isChecked;
  final Function(bool?) onChanged;

  const PdfViewerWidget({
    super.key,
    required this.title,
    required this.pdfUrl,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final RxDouble scale = 1.0.obs;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
        title: ScaleFactorAutoSizeText(
          text: title,
          style: Get.theme.primaryTextTheme.bodyLarge?.copyWith(
            color: AppColors.darkTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        forceMaterialTransparency: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: AppColors.darkGreyColor,
            thickness: 0.5,
          ),
        ),
      ),
      body: Stack(
        children: [
          // PDF Görüntüleme
          Obx(
            () => Transform.scale(
              scale: scale.value,
              child: const PDF().cachedFromUrl(
                pdfUrl,
                placeholder: (progress) => Center(
                    child: CircularProgressIndicator(value: progress / 100)),
                errorWidget: (error) =>
                    Center(child: Text("Yükleme Hatası: $error")),
              ),
            ),
          ),

          // Zoom In/Out Butonları
          Positioned(
            bottom: 100,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.darkTextColor,
                  borderRadius: BorderRadius.circular(999.r)),
              child: Column(
                children: [
                  FloatingActionButton(
                    backgroundColor: AppColors.darkTextColor,
                    onPressed: () => scale.value += 0.1,
                    mini: true,
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white,
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: AppColors.darkTextColor,
                    onPressed: () => scale.value -= 0.1,
                    mini: true,
                    child: const Icon(
                      Icons.remove,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // "Onayla" Butonu
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: SizedBox(
                width: Get.width * 0.7,
                child: CustomButton(
                  borderRadius: 999.r,
                  onTap: () {
                    onChanged(!isChecked
                        .value); // Değerin tersini alarak güncelliyoruz
                    Get.back(); // Geri git
                  },
                  backgroundColor: AppColors.primaryColor,
                  child: ScaleFactorAutoSizeText(
                    text: "Onayla",
                    style: Get.theme.primaryTextTheme.bodyLarge?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
