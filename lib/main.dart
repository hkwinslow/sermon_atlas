import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sermon_atlas/cubit/sermon_cubit.dart';
import 'package:sermon_atlas/data/sermon_repository.dart';
import 'package:sermon_atlas/pages/sermon_search_page.dart';
import 'package:sermon_atlas/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder> {
        '/screen1': (BuildContext context) => new LoginPage(),
        '/screen2' : (BuildContext context) => new SermonSearchPage(),
      },
      title: 'Material App',
      home: BlocProvider(
        create: (context) => SermonCubit(FakeSermonRepository()),
        child: SermonSearchPage(),
      ),
      //home: LoginPage()
    );
  }
}