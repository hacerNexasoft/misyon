import 'dart:io';
import 'package:common/common.dart';
import 'package:misyonbank/product/constants/app_constants.dart';
import 'package:misyonbank/product/constants/get_storage_keys.dart';
import 'package:misyonbank/product/localization/language_model.dart';
import 'package:misyonbank/product/services/cache_box_service.dart';
import 'package:timezone/data/latest.dart' as tz;

class LocalizationService extends GetxService {
  final _cacheService = Get.find<CacheService>();

  late LanguageModel languageModel;

  Locale getLocale() {
    return _locale('tr', 'TR');
    //return _locale(languageModel.languageCode, languageModel.countryCode);
  }

  Future<void> setLocale({required LanguageModel languageModel}) async {
    try {
      this.languageModel = languageModel;
      await Get.updateLocale(_locale(languageModel.languageCode, languageModel.countryCode));
      await setLanguage(languageModel);
    } catch (e) {
      rethrow;
    }
  }


   Future<void> initLocale() async {
    try {
      var languageData = await getLanguage();
      if (languageData != null) {
        languageModel = languageData;
      } else {
        tz.initializeTimeZones();
        var localeNameList = Platform.localeName.toString().split('_');
        if (localeNameList[0] == 'tr') {
          languageModel = AppConstants.languageModelTr;
        } else {
          languageModel = AppConstants.languageModelEn;
        }
      }
    } catch (e) {
      languageModel = AppConstants.languageModelEn;
    }
  }

  Future<bool> setLanguage(LanguageModel languageModel) async {
    try {
      var isSaved = await _cacheService.save(
        box: CacheBoxService.languageBox,
        key: GetStorageKeys.languageBoxKey,
        value: languageModel.toJson(),
      );
      return isSaved;
    } catch (e) {
      rethrow;
    }
  }
  Future<LanguageModel?> getLanguage() async {
    try {
      var data = await _cacheService.getData<Map<String, dynamic>>(
        box: CacheBoxService.languageBox,
        key: GetStorageKeys.languageBoxKey,
      );
      return LanguageModel.decoder(data);
    } catch (e) {
      rethrow;
    }
  }

  Locale _locale(String languageCode, String countryCode) {
    return (languageCode.isNotEmpty && countryCode.isNotEmpty)
        ? Locale(languageCode, countryCode)
        : Locale(AppConstants.languageModelEn.languageCode, AppConstants.languageModelEn.countryCode);
  }

  bool get isEn {
    return languageModel.languageCode == 'en';
  }
}
