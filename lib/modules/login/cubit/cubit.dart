import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix= Icons.visibility_outlined;

  void changePasswordVisibility()
  {
    isPassword =! isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(LoginChangePasswordVisibilityState());
  }

  late LoginModel loginModel;

  void getLogin({
    required String email,
    required String password,
  }) {
    emit(LoginGetLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginGetSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginGetErrorState(error.toString()));
      print(error.toString());
    });
  }


  late LoginModel registerModel;

  void getRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterGetLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      emit(RegisterGetSuccessState(registerModel));
    }).catchError((error) {
      emit(RegisterGetErrorState(error.toString()));
      print(error.toString());
    });
  }
}
