// ignore_for_file: file_names

class Token {
  String? token;
  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token'],
    );
  }

  @override
  String toString() {
    return "Token($token)";
  }
}
