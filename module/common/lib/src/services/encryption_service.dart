import 'package:common/common.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService extends BaseGetxService {
  final encrypt.Key _key;
  final encrypt.IV _iv;

  EncryptionService(String keyBase64, String ivBase64)
      : _key = encrypt.Key.fromBase64(keyBase64),
        _iv = encrypt.IV.fromBase64(ivBase64);

  encrypt.Encrypted encryptData(String data) {
    try {
      final encrypter = encrypt.Encrypter(encrypt.AES(_key));

      return encrypter.encrypt(data, iv: _iv);
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }

  String decryptData(encrypt.Encrypted data) {
    try {
      final encrypter = encrypt.Encrypter(encrypt.AES(_key));

      return encrypter.decrypt(data, iv: _iv);
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }

  static String generateKeyBase64() {
    final key = encrypt.Key.fromLength(32);
    return key.base64;
  }

  static String generateIvBase64() {
    final iv = encrypt.IV.fromLength(16);
    return iv.base64;
  }
}
