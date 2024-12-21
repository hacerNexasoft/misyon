part of '../../../invest_view.dart';

class _ReadAndAcceptWidget extends BaseGetView<InvestViewController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _readAndAcceptItem(
          underlinedText: 'Kampanya Bilgi Formu',
          contentText:
              '\'nu okudum. Verilerimin belirtilen amaçlarla işlenmesini ve aktarılmasını kabul ediyorum.',
          isChecked: controller.isCampaignAccepted,
          onChangedPdf: PdfViewerWidget(
            isChecked: controller.isCampaignAccepted,
            title: "Kampanya Bilgi Formu",
            pdfUrl:
                'https://www.ziraatbank.com.tr/tr/Forms/banka-kart-urun-bilgi-formu.pdf',
            onChanged: controller.onCampaignAccepted,
          ),
          onChanged: controller.onCampaignAccepted,
        ),
        Divider(
          color: AppColors.darkGreyColor,
          thickness: .2,
          indent: 40.w,
          endIndent: 40.w,
        ),
        _readAndAcceptItem(
          underlinedText:
              'Kitle Fonlaması Faaliyetleri Genel Risk Bildirimi Metni',
          contentText:
              '\'ni okudum. Verilerimin belirtilen amaçlarla işlenmesini ve aktarılmasını kabul ediyorum.',
          isChecked: controller.isRiskAccepted,
          onChangedPdf: PdfViewerWidget(
              isChecked: controller.isRiskAccepted,
              pdfUrl:
                  'https://www.ziraatbank.com.tr/tr/Forms/banka-kart-urun-bilgi-formu.pdf',
              title: "Kitle Fonlaması Faaliyetleri Genel Risk Bildirimi Metni",
              onChanged: controller.onRiskAccepted),
          onChanged: controller.onRiskAccepted,
        ),
      ],
    );
  }

  Widget _readAndAcceptItem({
    required String underlinedText,
    required String contentText,
    required RxBool isChecked,
    required Function(bool?) onChanged,
    required Widget onChangedPdf,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Row(
          children: [
            Flexible(
              child: InkWell(
                onTap: () => Get.to(() => onChangedPdf),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: underlinedText,
                        style: theme.primaryTextTheme.bodySmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: contentText,
                        style: theme.primaryTextTheme.bodySmall?.copyWith(
                          color: AppColors.darkGreyColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Checkbox(
                value: isChecked.value,
                activeColor: AppColors.primaryColor,
                focusColor: AppColors.primaryColor,
                checkColor: AppColors.primaryColor,
                side: const BorderSide(
                  color: AppColors.checkboxBorderColor,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
                fillColor: WidgetStateProperty.all(AppColors.fillColor),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      );
}
