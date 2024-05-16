class ChangePasswordModel {
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePasswordModel({
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      currentPassword: json['currentPassword'] as String?,
      newPassword: json['newPassword'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };
}
