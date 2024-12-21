import 'package:common/common.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';

class PDFViewerFromUrl extends BaseStatelessWidget {
  final String url;

  const PDFViewerFromUrl({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const PDF().fromUrl(
        url,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) =>
            CustomErrorWidget(text: LocalizationKeys.emptySearchTextKey.tr),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
    );
  }
}
