import 'package:common/common.dart';
import 'package:misyonbank/product/localization/languages/language_en.dart';
import 'package:misyonbank/product/localization/languages/language_tr.dart';

class AppLanguages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'tr_TR': trTR,
      };
}
