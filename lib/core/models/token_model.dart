class TokenModel {
  final String accessToken;
  final String refreshToken;
  final DateTime accessTokenExpiry;
  final DateTime refreshTokenExpiry;

  TokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiry,
    required this.refreshTokenExpiry,
  });

  bool get isAccessTokenExpired => DateTime.now().isAfter(accessTokenExpiry);
  bool get isRefreshTokenExpired => DateTime.now().isAfter(refreshTokenExpiry);

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'accessTokenExpiry': accessTokenExpiry.toIso8601String(),
        'refreshTokenExpiry': refreshTokenExpiry.toIso8601String(),
      };

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        accessTokenExpiry: DateTime.parse(json['accessTokenExpiry']),
        refreshTokenExpiry: DateTime.parse(json['refreshTokenExpiry']),
      );
}
