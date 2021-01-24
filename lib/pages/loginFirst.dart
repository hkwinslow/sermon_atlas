import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sermon_atlas/cubit/sermon_cubit.dart';
import 'package:sermon_atlas/data/sermon_repository.dart';
import 'package:sermon_atlas/pages/sermon_search_page.dart';

class MyPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MyPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => SermonCubit(context.read<FakeSermonRepository>()),
          child: SermonSearchPage(),
        ),
      ),
    );
  }
}