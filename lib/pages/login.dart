import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:sermon_atlas/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                  //Reset state to initial or it will only ever show first error and no subsequent errors
                  context.read<LoginCubit>().emit(LoginInitial());
                }
              },
              builder: (context, state) {
                if (state is LoginInitial) {
                  return loginLayout();
                } else if (state is LoginLoading) {
                  return tryingFirebase();
                } else if (state is LoginComplete) {
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.pushReplacementNamed(context, '/sermonSearchPage');
                  });
                  //TODO: should i really be resetting state right here or
                  //will having a login bloc solve this problem?
                  context.read<LoginCubit>().emit(LoginInitial());
                  return Container();
                } else {
                  return loginLayout();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget tryingFirebase() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget loginLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 155.0,
          child: Image.asset(
            "assets/church_img.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 45.0),
        emailField(),
        SizedBox(height: 25.0),
        passwordField(),
        SizedBox(
          height: 35.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [loginButton(), SizedBox(width: 10), signupButton()],
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }

  Widget emailField() { 
    return TextField(
      controller: _emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget passwordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget loginButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        //minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          //Note: used to have async after onPressed:() and before {

          final loginCubit = context.read<LoginCubit>();
          loginCubit.getLogin(_emailController.text, _passwordController.text);

        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget signupButton() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.blue),
        children: <TextSpan>[
          TextSpan(
              text: 'New user? Sign up',
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacementNamed(context, '/signupPage');
                }),
        ],
      ),
    );
  }
}
