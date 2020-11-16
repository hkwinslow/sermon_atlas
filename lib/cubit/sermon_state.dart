part of 'sermon_cubit.dart';

@immutable
abstract class SermonState {
  const SermonState();
}

class SermonInitial extends SermonState {
  const SermonInitial();
}

class SermonLoading extends SermonState {
  const SermonLoading();
}

class SermonLoaded extends SermonState {
  final List<Sermon> sermon;
  const SermonLoaded(this.sermon);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SermonLoaded && o.sermon == sermon;
  }

  @override
  int get hashCode => sermon.hashCode;
}

class SermonError extends SermonState {
  final String message;
  const SermonError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SermonError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}