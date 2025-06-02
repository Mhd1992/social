import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/components/widget_main.dart';
import 'package:social_application/cubit/login/login_cubit.dart';
import 'package:social_application/cubit/register/register_cubit.dart';
import 'package:social_application/cubit/register/register_state.dart';

import '../cubit/login/login_state.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  SocialRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {}
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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Register now to browse our hot offers ',
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
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter name !';
                        }
                      },
                      label: 'Name ',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    defaultFormFiled(
                      controller: nameController,
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
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter phone !';
                        }
                      },
                      label: 'phone ',
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    defaultFormFiled(
                        controller: phoneController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          //  return 'please enter password !';
                        },
                        isPassword: RegisterCubit.get(context).isPassword,
                        isPressed:
                            RegisterCubit.get(context).changePasswordVisibility,
                        label: 'password',
                        prefix: Icons.lock,
                        suffix: RegisterCubit.get(context).suffixIcon),
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
                            /* if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context)(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }*/
                          },
                          color: Colors.blueAccent,
                          child: const Text(
                            'REGISTER',
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
