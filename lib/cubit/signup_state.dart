part of 'signup_cubit.dart';

@immutable
abstract class SignupState {
  const SignupState();
}

class SignupInitial extends SignupState {
  const SignupInitial();
}

class SignupLoading extends SignupState {
  const SignupLoading();
}

class SignupComplete extends SignupState {
  const SignupComplete();
  // final List<String> signup;
  // const SignupComplete(this.signup);

  // @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;

  //   return o is SignupComplete && o.signup == signup;
  // }

  // @override
  // int get hashCode => signup.hashCode;
}

class SignupError extends SignupState {
  final String message;
  const SignupError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SignupError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}