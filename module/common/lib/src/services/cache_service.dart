import 'package:common/src/base/base_getx_service.dart';
import 'package:get_storage/get_storage.dart';

class CacheService extends BaseGetxService {
  String? localPath;

  Future<bool> save({required GetStorage box, required String key, required dynamic value}) async {
    bool? error;
    try {
      await box.write(key, value);
    } catch (e) {
      error = true;
      logger.e(e);
    }
    return error == null;
  }

  dynamic getData<T>({required GetStorage box, required String key}) {
    return box.read<T>(key);
  }

  Future<void> deleteData({required GetStorage box, required String key}) async {
    try {
      await box.remove(key);
    } catch (e) {
      logger.e(e);
    }
  }
}
