
class LanguageModel {
  final String symbol;
  final String language;
  final String countryCode;
  final String languageCode;

  const LanguageModel({
    required this.symbol,
    required this.language,
    required this.languageCode,
    required this.countryCode,
  });

  factory LanguageModel.fromJson(Map<dynamic, dynamic> json) => LanguageModel(
        symbol: json['symbol'].toString(),
        language: json['language'].toString(),
        languageCode: json['languageCode'].toString(),
        countryCode: json['countryCode'].toString(),
      );

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'language': language,
      'languageCode': languageCode,
      'countryCode': countryCode,
    };
  }

  static LanguageModel? decoder(Map<String, dynamic> data) {
    try {
      return LanguageModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }
}
