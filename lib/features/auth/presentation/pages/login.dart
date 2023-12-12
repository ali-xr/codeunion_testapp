import 'package:codeunion_testapp/assets/colors/colors.dart';
import 'package:codeunion_testapp/assets/constants/app_icons.dart';
import 'package:codeunion_testapp/features/auth/presentation/bloc/login_sign_up_bloc/login_sign_up_bloc.dart';
import 'package:codeunion_testapp/features/auth/presentation/pages/register.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/auth_header.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/default_text_field.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/fade.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/password_text_field.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/w_button.dart';
import 'package:codeunion_testapp/features/common/presentation/bloc/show_pop_up/show_pop_up_bloc.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/custom_screen.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController passwordController;
  late TextEditingController loginController;
  bool hasLoginError = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    loginController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return CustomScreen(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarContrastEnforced: false,
        ),
        child: WKeyboardDismisser(
          child: BlocBuilder<LoginSignUpBloc, LoginSignUpState>(
            builder: (context, state) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: darkGreen,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthHeader(
                      title: 'Enter',
                      subTitle: 'Your Account',
                      showBackButton: true,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                            16, 16, 16, 16 + mediaQuery.padding.bottom),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, -4),
                              blurRadius: 20,
                              color: woodSmoke.withOpacity(0.06),
                            )
                          ],
                          color: white,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultTextField(
                              title: 'Login',
                              controller: loginController,
                              maxLines: 1,
                              onChanged: (value) {
                                if (hasLoginError) {
                                  setState(() {
                                    hasLoginError = false;
                                  });
                                }
                              },
                              hasError:
                                  hasLoginError && state.loginStatus.isSuccess,
                              hintText: 'Write Login',
                              prefix: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 8),
                                child: SvgPicture.asset(AppIcons.user),
                              ),
                            ),
                            const SizedBox(height: 16),
                            PasswordTextField(
                              title: 'password',
                              hintText: 'enter password',
                              hasError:
                                  hasLoginError && state.loginStatus.isFailure,
                              onChanged: (value) {
                                if (hasLoginError) {
                                  setState(() {
                                    hasLoginError = false;
                                  });
                                }
                              },
                              controller: passwordController,
                            ),
                            const Spacer(),
                            WButton(
                              text: 'Enter',
                              isLoading: state.loginStatus.isInProgress,
                              onTap: () => context.read<LoginSignUpBloc>().add(
                                    Login(
                                      email: loginController.text,
                                      password: passwordController.text,
                                      onError: (message) {
                                        hasLoginError = true;
                                        context.read<ShowPopUpBloc>().add(
                                              ShowPopUp(
                                                  message: message.replaceAll(
                                                      RegExp(r'\{?\[?\]?\.?}?'),
                                                      '')),
                                            );
                                      },
                                    ),
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No Account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(),
                                ),
                                const SizedBox(width: 4),
                                WScaleAnimation(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      fade(
                                        page: const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Register',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
