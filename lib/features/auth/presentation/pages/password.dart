import 'package:codeunion_testapp/features/auth/presentation/bloc/login_sign_up_bloc/login_sign_up_bloc.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/password_text_field.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/w_button.dart';
import 'package:codeunion_testapp/features/common/presentation/bloc/show_pop_up/show_pop_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool isObscure = true;

  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginSignUpBloc, LoginSignUpState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              16, 0, 16, 16 + MediaQuery.of(context).padding.bottom),
          child: Column(
            children: [
              PasswordTextField(
                title: 'Password',
                controller: passwordController,
                onChanged: (value) {},
                hintText: 'Enter Password',
                isObscure: isObscure,
                suffixTap: () {
                  print('suffix => 1 ${isObscure}');
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              const SizedBox(height: 16),
              PasswordTextField(
                title: 'Confirm Password',
                controller: confirmPasswordController,
                onChanged: (value) {},
                hintText: 'Confirm Password',
                isObscure: isObscure,
                suffixTap: () {
                  print('suffix => 1 ${isObscure}');
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              const Spacer(),
              WButton(
                text: 'Confirm',
                isLoading: state.registerNewUserStatus.isInProgress,
                onTap: () {
                  context.read<LoginSignUpBloc>().add(SubmitPassword(
                      confirmPassword: confirmPasswordController.text,
                      password: passwordController.text,
                      onError: (message) {
                        context
                            .read<ShowPopUpBloc>()
                            .add(ShowPopUp(message: message));
                      }));
                },
              )
            ],
          ),
        );
      },
    );
  }
}
