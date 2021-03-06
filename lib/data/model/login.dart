import 'package:meta/meta.dart';

class Login {
  final String title;
  final String location;
  final DateTime date;

  Login({
    @required this.title,
    @required this.location,
    @required this.date,
  });

  //TODO: figure out what this section means and if its correct
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Login &&
        o.title == title &&
        o.location == location &&
        o.date == date;
  }
  //TODO: figure out what this section means and if its correct
  @override
  int get hashCode => title.hashCode ^ location.hashCode ^ date.hashCode;
}