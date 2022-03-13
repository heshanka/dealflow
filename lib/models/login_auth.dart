class LoginAuth {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  int? expiresIn;

  LoginAuth({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
  });

  factory LoginAuth.fromJson(Map<String, dynamic> json) {
    return LoginAuth(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
    );
  }

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'token_type': tokenType,
    'expires_in': expiresIn,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LoginAuth &&
              runtimeType == other.runtimeType &&
              accessToken == other.accessToken &&
              refreshToken == other.refreshToken &&
              tokenType == other.tokenType &&
              expiresIn == other.expiresIn;

  @override
  int get hashCode =>
      accessToken.hashCode ^ refreshToken.hashCode ^ tokenType.hashCode ^ expiresIn.hashCode;

  @override
  String toString() {
    return 'LoginAuth{accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expiresIn: $expiresIn}';
  }
}
