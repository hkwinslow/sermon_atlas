import 'package:bloc/bloc.dart';
import 'package:sermon_atlas/data/model/signup.dart';
import 'package:sermon_atlas/data/signup_repository.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _signupRepository;

  SignupCubit(this._signupRepository) : super(SignupInitial());

  Future<void> getSignup(String email, String password) async {
    try {
      emit(SignupLoading());
      final result = await _signupRepository.fetchSignup(email, password);
      if (result.first == 'success') {
        print('SIGNUP COMPLETE---------');
        emit(SignupComplete());
      }
      else {
        print('ERROR---------');
        print(result.first);
        emit(SignupError(result.first));
      }
    } on NetworkException {
      emit(SignupError("Couldn't fetch signups. Is the device online?"));
    }
  }
}