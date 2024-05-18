class ResetPasswordModel {
  String? newPassword;
  String? confirmPassword;
  String? token;
  String? email;

  ResetPasswordModel({
    this.newPassword,
    this.confirmPassword,
    this.token,
    this.email,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      newPassword: json['newPassword'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      token: json['token'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
        'token': token,
        'email': email,
      };
}
