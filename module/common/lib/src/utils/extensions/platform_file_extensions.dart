import 'package:file_picker/file_picker.dart';

class PlatformFileSerialization {
  static Map<String, dynamic> toJson(PlatformFile? file) {
    if (file == null) return {};

    return {
      'name': file.name,
      'path': file.path,
      'bytes': file.bytes,
      'size': file.size,
      'extension': file.extension,
    };
  }

  static PlatformFile? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return null;

    return PlatformFile(
      name: json['name'],
      path: json['path'],
      bytes: json['bytes'],
      size: json['size'],
    );
  }
}