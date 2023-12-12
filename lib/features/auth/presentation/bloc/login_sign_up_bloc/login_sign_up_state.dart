part of 'login_sign_up_bloc.dart';

class LoginSignUpState extends Equatable {
  final FormzSubmissionStatus loginStatus;
  final FormzSubmissionStatus registerNewUserStatus;
  final String phone;
  final String confirmationType;
  final String email;

  const LoginSignUpState({
    required this.loginStatus,
    required this.registerNewUserStatus,
    required this.phone,
    required this.confirmationType,
    required this.email,
  });

  const LoginSignUpState.empty([
    this.loginStatus = FormzSubmissionStatus.initial,
    this.registerNewUserStatus = FormzSubmissionStatus.initial,
    this.phone = '',
    this.confirmationType = 'phone',
    this.email = '',
  ]);

  LoginSignUpState copyWith({
    FormzSubmissionStatus? loginStatus,
    FormzSubmissionStatus? registerNewUserStatus,
    String? phone,
    String? confirmationType,
    String? email,
  }) =>
      LoginSignUpState(
        loginStatus: loginStatus ?? this.loginStatus,
        registerNewUserStatus:
            registerNewUserStatus ?? this.registerNewUserStatus,
        phone: phone ?? this.phone,
        confirmationType: confirmationType ?? this.confirmationType,
        email: email ?? this.email,
      );

  @override
  List<Object?> get props => [
        loginStatus,
        registerNewUserStatus,
        phone,
        confirmationType,
        email,
      ];
}
