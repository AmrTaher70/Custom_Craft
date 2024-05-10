class SignUpModel {
  String? userName;
  String? email;
  String? password;
  String? confirmPassword;

  SignUpModel({
    this.userName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        userName: json['userName'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        confirmPassword: json['confirmPassword'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
