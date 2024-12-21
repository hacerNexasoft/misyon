
import 'package:common/common.dart';
import 'package:get_storage/get_storage.dart';
import 'package:misyonbank/product/constants/get_storage_keys.dart';

class CacheBoxService extends BaseGetxService {
  static final languageBox = GetStorage(GetStorageKeys.languageBoxKey);

  static Future<void> initBoxes() async {
    await GetStorage.init(GetStorageKeys.languageBoxKey);
  }
}