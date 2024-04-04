import 'package:product_app/modules/auth/domain/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity {
  const SignInModel({required String email,required String password})
      : super(email: email, password: password);


  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}