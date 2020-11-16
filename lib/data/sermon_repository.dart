import 'dart:math';
import 'model/sermon.dart';

abstract class SermonRepository {
  /// Throws [NetworkException].
  Future<List<Sermon>> fetchSermon(String cityName);
}

class FakeSermonRepository implements SermonRepository {
  @override
  Future<List<Sermon>> fetchSermon(String cityName) {
    List<Sermon> sermons = new List<Sermon>();
    sermons.add(new Sermon(title: 'Faith', location: 'Norman', date: DateTime.parse("2016-02-17")));
    sermons.add(new Sermon(title: 'Love', location: 'Purcell', date: DateTime.parse("2012-08-12")));
    sermons.add(new Sermon(title: 'Hope', location: 'Penn South', date: DateTime.parse("2018-12-14")));
    sermons.add(new Sermon(title: 'Ressurrection', location: 'Amarillo', date: DateTime.parse("2020-01-28")));
    sermons.add(new Sermon(title: 'Joy', location: 'Pasadena', date: DateTime.parse("2015-05-03")));
    sermons.add(new Sermon(title: 'Names of God', location: 'Bridgeport', date: DateTime.parse("2017-09-30")));
    sermons.add(new Sermon(title: 'Jesus\' Parables', location: 'Ardmore', date: DateTime.parse("2019-07-02")));
    sermons.add(new Sermon(title: 'Woman at the Well', location: 'Tulsa', date: DateTime.parse("2017-03-18")));
    sermons.add(new Sermon(title: 'Visions of Zechariah', location: 'Plainview', date: DateTime.parse("2020-11-08")));
    sermons.add(new Sermon(title: 'Love our Enemies', location: 'Elk City', date: DateTime.parse("2011-10-31")));
    sermons.add(new Sermon(title: 'Marriage', location: 'Sooner East', date: DateTime.parse("2019-06-05")));
    sermons.add(new Sermon(title: 'Salvation', location: 'Seminole', date: DateTime.parse("2018-04-22")));
    sermons.add(new Sermon(title: 'Baptism', location: 'College Park', date: DateTime.parse("2016-12-25")));
    sermons.add(new Sermon(title: 'The Church', location: 'Pearland', date: DateTime.parse("2017-07-19")));
    sermons.add(new Sermon(title: 'Creation', location: 'Orange', date: DateTime.parse("2020-02-17")));
    sermons.add(new Sermon(title: 'Forgiveness', location: 'Norman', date: DateTime.parse("2019-05-30")));
    sermons.add(new Sermon(title: 'Redemption', location: 'Ft. Smith', date: DateTime.parse("2018-09-11")));

    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        // Simulate some network exception
        //TODO: uncomment 3 lines below if I want to randomly throw error state to
        //test that state in the bloc. But when I have db then the error state
        //shouldn't be random, it should be when db fails to add, update, delete or search
        // if (random.nextBool()) {
        //   throw NetworkException();
        // }

        return sermons;
      },
    );
  }
}

class NetworkException implements Exception {}