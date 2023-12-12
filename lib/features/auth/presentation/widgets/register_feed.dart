import 'package:codeunion_testapp/assets/colors/colors.dart';
import 'package:codeunion_testapp/assets/constants/app_icons.dart';
import 'package:codeunion_testapp/features/auth/presentation/bloc/login_sign_up_bloc/login_sign_up_bloc.dart';
import 'package:codeunion_testapp/features/auth/presentation/pages/login.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/default_text_field.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/fade.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/info_container.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/w_button.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class RegisterFeed extends StatefulWidget {
  final PageController pageController;

  const RegisterFeed({required this.pageController, Key? key})
      : super(key: key);

  @override
  State<RegisterFeed> createState() => _RegisterFeedState();
}

class _RegisterFeedState extends State<RegisterFeed> {
  late TextEditingController loginController;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    loginController = TextEditingController();
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
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    DefaultTextField(
                      title: 'Name',
                      maxLines: 1,
                      controller: nameController,
                      onChanged: (value) {},
                      hasError: nameController.text.isEmpty,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 8),
                        child: SvgPicture.asset(AppIcons.user),
                      ),
                      hintText: 'Write Full Name',
                    ),
                    const SizedBox(height: 16),
                    DefaultTextField(
                      title: 'Login',
                      controller: loginController,
                      onChanged: (value) {},
                      maxLines: 1,
                      // hasError: state.checkUsernameStatus.isSubmissionFailure,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 8),
                        child: SvgPicture.asset(AppIcons.user),
                      ),
                      hintText: 'Create Login',
                    ),
                    const SizedBox(height: 12),
                    const InfoContainer(),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                    text: 'Privacy1',
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: 'Privacy2',
                        recognizer: TapGestureRecognizer()..onTap = () async {},
                        onEnter: (_) {},
                        onExit: (_) {},
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: primary),
                      ),
                      TextSpan(
                          text: 'Privacy3',
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: const []),
                    ]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              WButton(
                text: 'Proceed',
                isLoading: state.registerNewUserStatus.isInProgress,
                onTap: () {
                  // context
                  //     .read<LoginSignUpBloc>()
                  //     .add(
                  // CheckUsername(
                  //   username: loginController.text,
                  //   fullName: nameController.text,
                  //   onError: (message) {
                  //     context.read<ShowPopUpBloc>().add(ShowPopUp(
                  //         message:
                  //             message.replaceAll(RegExp(r'{?}?'), '')));
                  //   },
                  //   onSuccess: () {
                  //     widget.pageController.animateToPage(1,
                  //         duration: const Duration(milliseconds: 150),
                  //         curve: Curves.linear);
                  //   },
                  // ),
                  // );
                },
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                  ),
                  const SizedBox(width: 4),
                  WScaleAnimation(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacement(fade(page: const LoginScreen()));
                    },
                    child: Text(
                      'Enter',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
