import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      'Register',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      prefix: Icons.person_outline_outlined,
                      label: 'Name',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Name Must not be Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.name,
                      prefix: Icons.email,
                      label: 'Email',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Email Must not be Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      prefix: Icons.phone,
                      label: 'Phone',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Must not be Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        prefix: Icons.lock_outlined,
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
                    defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          navigateAndFinish(context, LoginScreen());
                        }
                      },
                      text: 'LOGIN',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
