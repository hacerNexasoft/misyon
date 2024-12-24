import 'package:common/common.dart';
import 'package:get_storage/get_storage.dart';
import 'package:misyonbank/product/constants/get_storage_keys.dart';

class CacheBoxService extends BaseGetxService {
  static final languageBox = GetStorage(GetStorageKeys.languageBoxKey);
  static final tokenBox = GetStorage(GetStorageKeys.tokenBoxKey);

  static Future<void> initBoxes() async {
    await GetStorage.init(GetStorageKeys.languageBoxKey);
    await GetStorage.init(GetStorageKeys.tokenBoxKey);
  }

  static Future<void> saveJwtToken(String token) async {
    await tokenBox.write('jwtToken', token);
  }

  static String? getJwtToken() {
    return tokenBox.read('jwtToken');
  }

  static Future<void> clearJwtToken() async {
    await tokenBox.remove('jwtToken');
  }
}
