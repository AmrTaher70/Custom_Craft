import 'package:custom_craft/api/sign_up_model.dart';
import 'package:custom_craft/helper/api.helper.dart';

class AddSignUp {
  Future<SignUpModel> addsignup({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    Map<String, dynamic> data = await Api()
        .post(url: 'http://customcraftt.somee.com/api/Account/register', body: {
      'userName': userName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    });
    return SignUpModel.fromJson(data);
  }
}
