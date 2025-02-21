import 'dart:convert';
import 'dart:io';
import 'package:common/common.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:widgets/components.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PDFViewerFromBase64 extends BaseStatelessWidget {
  final String data;

  const PDFViewerFromBase64({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _saveBase64PdfToTempFile(data),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return CustomErrorWidget(text: snapshot.error.toString());
        } else {
          final file = snapshot.data!;
          return Scaffold(
            appBar: _buildAppBar(),
            body: const PDF().fromPath(
              file.path,
            ),
          );
        }
      },
    );
  }

  Future<File> _saveBase64PdfToTempFile(String base64Pdf) async {
    final bytes = base64Decode(base64Pdf);
    final directory = await getTemporaryDirectory();
    final file = File(path.join(directory.path, 'temp.pdf'));
    await file.writeAsBytes(bytes);
    return file;
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
    );
  }
}
