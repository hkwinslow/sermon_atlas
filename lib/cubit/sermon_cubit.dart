import 'package:bloc/bloc.dart';
import 'package:sermon_atlas/data/model/sermon.dart';
import 'package:sermon_atlas/data/sermon_repository.dart';
import 'package:meta/meta.dart';

part 'sermon_state.dart';

class SermonCubit extends Cubit<SermonState> {
  final SermonRepository _sermonRepository;

  SermonCubit(this._sermonRepository) : super(SermonInitial());

  Future<void> getSermon() async {
    try {
      emit(SermonLoading());
      final sermons = await _sermonRepository.getSermons();
      emit(SermonLoaded(sermons));
    } on NetworkException {
      emit(SermonError("Couldn't fetch sermons. Is the device online?"));
    }
  }

  Future<void> addSermon(String cityName) async {
    try {
      emit(SermonLoading());
      try {
        await _sermonRepository.addUser();

      }
      catch (Exception){
        emit(SermonError("Something went wrong. Couldn't add sermon."));
      }
      
    } on NetworkException {
      emit(SermonError("Couldn't add sermon. Is the device online?"));
    }
  }
}