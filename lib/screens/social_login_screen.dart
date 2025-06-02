import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/components/widget_main.dart';
import 'package:social_application/cubit/login/login_cubit.dart';
import 'package:social_application/local/cache_helper.dart';
import 'package:social_application/screens/social_register_screen.dart';

import '../cubit/login/login_state.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.responseModel.status!) {
              showToastMessage(
                  message: state.responseModel.message.toString(),
                  state: ToastState.success);
              CacheHelper.saveData(
                  key: 'token', value: state.responseModel.data!.token);
              print('token is ${state.responseModel.data!.token}');
              Future.delayed(const Duration(seconds: 1));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Container()));
            } else {
              showToastMessage(
                  message: state.responseModel.message.toString(),
                  state: ToastState.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'login now to browse our hot offers ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    defaultFormFiled(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter email !';
                        }
                      },
                      label: 'Email ',
                      prefix: Icons.email,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    defaultFormFiled(
                        controller: passwordController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          //  return 'please enter password !';
                        },
                        isPassword: LoginCubit.get(context).isPassword,
                        isPressed:
                            LoginCubit.get(context).changePasswordVisibility,
                        label: 'password',
                        prefix: Icons.lock,
                        suffix: LoginCubit.get(context).suffixIcon),
                    const SizedBox(
                      height: 16,
                    ),
                    ConditionalBuilder(
                      condition: state is! LoginLoadState,
                      builder: (context) => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          color: Colors.blueAccent,
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Not Have account ?'),
                        defaultTextButton(
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SocialRegisterScreen()));
                            },
                            text: 'SignUp')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
