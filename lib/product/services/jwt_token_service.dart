import 'package:common/common.dart';
import 'package:misyonbank/product/services/cache_box_service.dart';

import 'package:logger/logger.dart';

class JwtTokenService extends BaseGetxService {
  final Rx<String?> _jwtToken = Rx<String?>(null);
  String? get jwtToken => _jwtToken.value;
  final Logger _logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _jwtToken.value = CacheBoxService.getJwtToken();
    if (_jwtToken.value != null) {
      _logger.i('JWT token önbellekten alındı: ${_jwtToken.value}');
    } else {
      _logger.w('Önbellekte JWT token bulunamadı');
    }
  }

  void setJwtToken(String token) async {
    _jwtToken.value = token;
    await CacheBoxService.saveJwtToken(token);
    _logger.i('JWT token önbelleğe kaydedildi: $token');
  }

  void clearJwtToken() {
    _jwtToken.value = null;
    CacheBoxService.clearJwtToken();
    _logger.i('JWT token önbellekten temizlendi');
  }
}
