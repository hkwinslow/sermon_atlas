import 'package:bloc/bloc.dart';
import 'package:sermon_atlas/data/model/login.dart';
import 'package:sermon_atlas/data/login_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(LoginInitial());

  Future<void> getLogin(String email, String password) async {
    try {
      emit(LoginLoading());
      final result = await _loginRepository.fetchLogin(email, password);

      if (result.first == 'success') {
        print('LOGIN COMPLETE---------');
        emit(LoginComplete());
      }
      else {
        print('ERROR---------');
        print(result.first);
        emit(LoginError(result.first));
      }
    } on NetworkException {
      emit(LoginError("Couldn't fetch logins. Is the device online?"));
    }
  }
}