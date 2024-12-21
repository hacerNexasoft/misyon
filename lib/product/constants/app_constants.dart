import 'package:misyonbank/product/localization/language_model.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/payment_type_model.dart';

class AppConstants {
  static final defaults = <String, dynamic>{};
  static const languageModelEn = LanguageModel(
    symbol: '🇺🇸',
    language: 'English',
    languageCode: 'en',
    countryCode: 'US',
  );
  static const languageModelTr = LanguageModel(
    symbol: '🇹🇷',
    language: 'Türkçe',
    languageCode: 'tr',
    countryCode: 'TR',
  );

  static List<String> detailViewTabs = [
    LocalizationKeys.summaryTextKey,
    LocalizationKeys.awardsTextKey,
    LocalizationKeys.detailsTextKey,
    LocalizationKeys.documentsFinancialsTextKey,
    LocalizationKeys.updatesTextKey,
    LocalizationKeys.faqTextKey,
    LocalizationKeys.qnaTextKey
  ];

  static const List<PaymentTypeModel> paymentTypes = [
    PaymentTypeModel(
      title: LocalizationKeys.individualPaymentTypeTextKey,
      value: LocalizationKeys.individualPaymentTypeTextKey,
    ),
    PaymentTypeModel(
      title: LocalizationKeys.housingRentPaymentTypeTextKey,
      value: LocalizationKeys.housingRentPaymentTypeTextKey,
    ),
    PaymentTypeModel(
      title: LocalizationKeys.otherPaymentTypeTextKey,
      value: LocalizationKeys.otherPaymentTypeTextKey,
    ),
    PaymentTypeModel(
      title: LocalizationKeys.financialPaymentTypeTextKey,
      value: LocalizationKeys.financialPaymentTypeTextKey,
    ),
    PaymentTypeModel(
      title: LocalizationKeys.investmentPaymentTypeTextKey,
      value: LocalizationKeys.investmentPaymentTypeTextKey,
    ),
    PaymentTypeModel(
      title: LocalizationKeys.educationPaymentTypeTextKey,
      value: LocalizationKeys.educationPaymentTypeTextKey,
    ),
    PaymentTypeModel(
      title: LocalizationKeys.eCommercePaymentTypeTextKey,
      value: LocalizationKeys.eCommercePaymentTypeTextKey,
    ),
  ];
}
