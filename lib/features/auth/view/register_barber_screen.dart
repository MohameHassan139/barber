import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../../../core/component/custom_textformfield.dart';
import '../controller/register_barber_cubit/register_barber_cubit.dart';
import '../controller/register_barber_cubit/register_barner_state.dart';

class RegistrationBarberScreen extends StatelessWidget {
  const RegistrationBarberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return RegistrationCubit();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: BlocConsumer<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            final controller = context.read<RegistrationCubit>();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is RegistrationLoading)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10),
                    // Profile Image picker
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: controller.backgroundImage != null
                                      ? DecorationImage(
                                          image: FileImage(File(controller
                                              .backgroundImage!.path)),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: controller.backgroundImage == null
                                    ? const Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                      )
                                    : null,
                              ),
                              const SizedBox(
                                height: 170,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      controller.pickBackgroundImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.pickProfileImage(),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: controller.profileImage != null
                                ? FileImage(controller.profileImage!)
                                : null,
                            child: controller.profileImage == null
                                ? const Icon(Icons.camera_alt, size: 30)
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'Enter Name',
                      labelText: 'Name',
                      textController: controller.nameController,
                      fieldType: TextInputType.name,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: 'Enter Email',
                      labelText: 'Email',
                      textController: controller.emailController,
                      fieldType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<RegistrationCubit, RegistrationState>(
                      builder: (context, state) {
                        var cubit = context.read<RegistrationCubit>();
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    labelText: 'Password',
                                    ispassword: cubit.isPasswordHidde,
                                    textController:
                                        cubit.passwordTextController,
                                    prefixIcon: const Icon(Icons.lock),
                                    suffix: IconButton(
                                      icon: Icon(cubit.isPasswordHidde
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        cubit.togglePasswordVisibility();
                                      },
                                    ),
                                    validator: ValidationBuilder()
                                        .minLength(3,
                                            'Password must be at least 3 characters')
                                        .maxLength(50,
                                            'Password cannot exceed 50 characters')
                                        .build(),
                                    hintText: 'password',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    labelText: 'Confirm Password',
                                    ispassword: cubit.isPasswordHidde,
                                    textController:
                                        cubit.rePasswordTextController,
                                    validator: ValidationBuilder()
                                        .minLength(3,
                                            'Password must be at least 3 characters')
                                        .maxLength(50,
                                            'Password cannot exceed 50 characters')
                                        .build(),
                                    hintText: 'Confirm Password',
                                    prefixIcon: const Icon(Icons.lock),
                                    suffix: IconButton(
                                      icon: Icon(cubit.isPasswordHidde
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        cubit.togglePasswordVisibility();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (!PasswordMatchState().passwordsMatch)
                              const Text(
                                "Passwords do not match",
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: 'bio',
                      labelText: 'bio',
                      textController: controller.passwordController,
                      fieldType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.description_outlined),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        controller.registerUser(
                          name: controller.nameController.text,
                          email: controller.emailController.text,
                          password: controller.passwordController.text,
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
