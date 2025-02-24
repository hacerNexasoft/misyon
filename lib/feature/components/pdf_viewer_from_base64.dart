import 'dart:convert';
import 'dart:io';
import 'package:common/common.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:widgets/components.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PDFViewerFromBase64 extends StatefulWidget {
  final String data;

  const PDFViewerFromBase64({super.key, required this.data});

  @override
  State<PDFViewerFromBase64> createState() => _PDFViewerFromBase64State();
}

class _PDFViewerFromBase64State extends State<PDFViewerFromBase64> {
  PDFViewController? controller;
  File? file;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _saveBase64PdfToTempFile(widget.data),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget(
            indicatorColor: AppColors.primaryColor,
          );
        } else if (snapshot.hasError) {
          return CustomErrorWidget(text: snapshot.error.toString());
        } else {
          return Scaffold(
            appBar: _buildAppBar(),
            body: PDF(
              onViewCreated: (ct) {
                if (controller == null) {
                  setState(() {
                    controller = ct;
                  });
                }
              },
            ).fromPath(
              file!.path,
            ),
          );
        }
      },
    );
  }

  Future<void> _saveBase64PdfToTempFile(String base64Pdf) async {
    if (file != null) return;
    final bytes = base64Decode(base64Pdf);
    final directory = await getTemporaryDirectory();
    final t = File(path.join(directory.path, 'temp.pdf'));
    await t.writeAsBytes(bytes);
    file = t;
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
    );
  }
}
