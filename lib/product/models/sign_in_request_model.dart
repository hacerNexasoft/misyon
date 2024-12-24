class SignInRequestModel {
  final String emailAddress;
  final String password;
  final String? location;
  final String? deviceInfo;

  SignInRequestModel({
    required this.emailAddress,
    required this.password,
    this.location,
    this.deviceInfo,
  });

  factory SignInRequestModel.fromJson(Map<String, dynamic> json) {
    return SignInRequestModel(
      emailAddress: json['emailAddress'] ?? '',
      password: json['password'] ?? '',
      location: json['location'],
      deviceInfo: json['deviceInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailAddress': emailAddress.isNotEmpty ? emailAddress : null,
      'password': password.isNotEmpty ? password : null,
      'location': location,
      'deviceInfo': deviceInfo,
    };
  }

  // Null Kontrolü
  bool hasNullFields() {
    return emailAddress.isEmpty || password.isEmpty;
  }
}
