import 'package:shop_app/models/login/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordVisibilityState extends LoginStates {}

class LoginGetLoadingState extends LoginStates {}

class LoginGetSuccessState extends LoginStates
{
  final LoginModel loginModel;

  LoginGetSuccessState(this.loginModel);
}

class LoginGetErrorState extends LoginStates {
  final String error;

  LoginGetErrorState(this.error);
}


class RegisterGetLoadingState extends LoginStates {}

class RegisterGetSuccessState extends LoginStates
{
  final LoginModel registerModel;

  RegisterGetSuccessState(this.registerModel);
}

class RegisterGetErrorState extends LoginStates {

  final String error;

  RegisterGetErrorState(this.error);

}