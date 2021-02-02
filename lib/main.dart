import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sermon_atlas/cubit/sermon_cubit.dart';
import 'package:sermon_atlas/cubit/signup_cubit.dart';
import 'package:sermon_atlas/cubit/login_cubit.dart';
import 'package:sermon_atlas/data/sermon_repository.dart';
import 'package:sermon_atlas/data/signup_repository.dart';
import 'package:sermon_atlas/data/login_repository.dart';
//import 'package:sermon_atlas/pages/sermon_search_page.dart';
import 'package:sermon_atlas/pages/login.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: <String, WidgetBuilder> {
//         '/loginPage': (BuildContext context) => new LoginPage(),
//         '/signupPage' : (BuildContext context) => new SermonSearchPage(),
//       },
//       title: 'Material App',
//       home: BlocProvider(
//         create: (context) => SermonCubit(FakeSermonRepository()),
//         child: SermonSearchPage(),
//       ),
//       //home: LoginPage()
//     );
//   }
// }

import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sermon_atlas/cubit/sermon_cubit.dart';
import 'package:sermon_atlas/pages/login.dart';
import 'package:sermon_atlas/pages/signup.dart';
import 'package:sermon_atlas/pages/sermon_search_page.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
    } else if (!_initialized) {
    } else {
      print('Good!!!------------------------------------');
    }
    // return MaterialApp(routes: <String, WidgetBuilder>{
    //   '/loginPage': (BuildContext context) => new LoginPage(),
    //   '/signupPage': (BuildContext context) => new SignUpPage(),
    //   '/try': (BuildContext context) => new MyPage(),

    // },
    // title: 'Material App',
    // //home: Navigator.push(context, '/loginPage'));
    // home: LoginPage());

    return MultiBlocProvider(
        providers: [
          BlocProvider<SermonCubit>(
            create: (context) => SermonCubit(FakeSermonRepository()),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(FakeSignupRepository()),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(FakeLoginRepository()),
          ),
        ],
        child: MaterialApp(
          routes: <String, WidgetBuilder>{
            '/loginPage': (BuildContext context) => new LoginPage(),
            '/signupPage': (BuildContext context) => new SignUpPage(),
            '/sermonSearchPage': (BuildContext context) => new SermonSearchPage(),
          },
          title: 'Material App',
          //home: Navigator.push(context, '/loginPage'));
          home: LoginPage(),
        ));
  }
  // Widget build(BuildContext context) {
  //   // Show error message if initialization failed
  //   if(_error) {
  //     //return SomethingWentWrong();
  //   }

  //   // Show a loader until FlutterFire is initialized
  //   if (!_initialized) {
  //     //return Loading();
  //   }
  //   print('HLLO0oooooooooooooooooooooooooooooooooo');

  //   return LoginPage();
  // }
}
