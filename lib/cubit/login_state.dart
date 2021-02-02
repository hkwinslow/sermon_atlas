part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginComplete extends LoginState {
  const LoginComplete();
  // final List<String> Login;
  // const LoginComplete(this.Login);

  // @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;

  //   return o is LoginComplete && o.Login == Login;
  // }

  // @override
  // int get hashCode => Login.hashCode;
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoginError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}