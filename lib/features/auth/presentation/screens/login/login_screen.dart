import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/common_text_field.dart';
import '../../../../../config/router.dart';
import '../../../../../core/helper/snackbar.dart';
import '../../../../../core/helper/validate_helper.dart';
import '../../../../../core/styles/colors/colors.dart';
import '../../../../../core/styles/icons/icons.dart';
import '../../bloc/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconsThemes.iconsApp,
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Masuk",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoaded) {
                      SnackBarSuccess.showSuccess(
                          context, "Berhasil masuk");
                      context.pushReplacementNamed(Routes.navbar);
                    }
                    if (state is LoginError) {
                      SnackBarError.showError(context, state.failure.message);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonTextFormField(
                        title: "Email",
                        validatorID: 1,
                        controller: emailController,
                        icons: Icons.email,
                        hint: "Masukkan email",
                        type: TextInputType.text,
                        obsecureText: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonTextFormField(
                        title: "Masukkan kata sandi",
                        validatorID: 0,
                        controller: passwordController,
                        icons: Icons.lock,
                        hint: "Masukkan kata sandi",
                        type: TextInputType.text,
                        obsecureText: true,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return AnimatedBuilder(
                            animation: Listenable.merge(
                                [emailController, passwordController]),
                            builder: (context, child) {
                              final isValid =
                                  (passwordController.text.isNotEmpty &&
                                          ValidateHelper.isPasswordValidateBool(
                                              passwordController.text)) &&
                                      (emailController.text.isNotEmpty &&
                                          ValidateHelper.isEmailValidateBool(
                                              emailController.text));
                              return CommonButton(
                                text: "Masuk",
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                        LoginAccountEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                },
                                haveRequirement: true,
                                isLoading: state is LoginLoading,
                                requirementComplete: isValid,
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Atau"),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun? ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    GestureDetector(
                      onTap: () => context.pushNamed(Routes.register),
                      child: Text(
                        "Daftar",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorsResources.colorsBlue,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
