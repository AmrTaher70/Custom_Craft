class LoginModel {
  String? email;
  String? password;
  bool? rememberMe;

  LoginModel({this.email, this.password, this.rememberMe});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json['email'] as String?,
        password: json['password'] as String?,
        rememberMe: json['rememberMe'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'rememberMe': rememberMe,
      };
}
