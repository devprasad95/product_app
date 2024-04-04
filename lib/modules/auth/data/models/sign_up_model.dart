import '../../domain/entities/sign_up_entity.dart';
class SignUpModel extends SignUpEntity {
  const SignUpModel({required String email,required String password,required String confirmPassword})
      : super(email: email, password: password,confirmPassword: confirmPassword);


  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(email: json['email'], password: json['password'],confirmPassword: json['confirmPassword']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password,'confirmPassword': confirmPassword};
  }
}