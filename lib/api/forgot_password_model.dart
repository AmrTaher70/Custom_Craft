class ForgotPasswordModel {
  dynamic userName;
  String? email;
  String? token;

  ForgotPasswordModel({this.userName, this.email, this.token});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      userName: json['userName'] as dynamic,
      email: json['email'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'token': token,
      };
}
