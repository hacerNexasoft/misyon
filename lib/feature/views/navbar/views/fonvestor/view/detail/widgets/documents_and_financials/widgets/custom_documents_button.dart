import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/feature/components/pdf_viewer_from_base64.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/models/document_model.dart';
import 'package:misyonbank/product/services/fetcher_static_service.dart';
import 'package:widgets/components.dart';

class CustomDocumentsButton extends BaseStatelessWidget {
  final String title;
  final String docID;

  const CustomDocumentsButton({required this.title, required this.docID, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DocumentModel? documentModel =
            await FetcherStaticService.fetchDocument(docID: docID, token: "");
        if (documentModel != null) {
          Get.to(() => PDFViewerFromBase64(
                data: documentModel.base64document,
              ));
        }
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
          mainAxisSize: MainAxisSize.min, // Sadece içeriğin genişliği kadar yer kaplasın
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
              text: title,
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
