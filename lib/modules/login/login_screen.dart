import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginGetSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.status!);
              print(state.loginModel.data!.token!);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token!,
              ).then((value) {
                navigateTo(context, ShopLayoutScreen(),);
              });
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.SUCCESS,
              );
            } else {
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = LoginCubit.get(context);

          return GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              prefix: Icons.email,
                              label: 'Email',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Email Must not be Empty';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              prefix: Icons.lock_outlined,
                              isPassword: cubit.isPassword,
                              suffix: cubit.suffix,
                              suffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              label: 'Password',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Password Must not be Empty';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginGetLoadingState,
                            builder: (BuildContext context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.getLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'LOGIN',
                            ),
                            fallback: (BuildContext context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                              ),
                              defaultTextButton(
                                function: () {
                                  navigateAndFinish(context, RegisterScreen());
                                },
                                text: 'Register now',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
