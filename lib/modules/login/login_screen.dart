import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
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
                        type: TextInputType.name,
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
                      function: ()
                      {
                        if(formKey.currentState!.validate())
                          {
                            print(emailController.text);
                            print(passwordController.text);
                        }
                      },
                      text: 'LOGIN',
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
                        TextButton(
                          onPressed: () {
                            navigateAndFinish(context, RegisterScreen());
                          },
                          child: const Text(
                            'Register Now',
                          ),
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
  }
}
