import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sermon_atlas/cubit/signup_cubit.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
              //Reset state to initial or it will only ever show first error and no subsequent errors
              context.read<SignupCubit>().emit(SignupInitial());
            }
          },
          builder: (context, state) {
            if (state is SignupInitial) {
              return signupLayout();
            } else if (state is SignupLoading) {
              return tryingFirebase();
            } else if (state is SignupComplete) {
              
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacementNamed(context, '/loginPage');
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sign-up complete. Please login.'),
                ),
              );
              });
              //TODO: should i really be resetting state right here or
              //will having a login bloc solve this problem?
              context.read<SignupCubit>().emit(SignupInitial());
              return Container();
              
            } else {
              return signupLayout();
            }
          },
        ),
      ),
      )
    );
  }

  Widget tryingFirebase() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget signupLayout() {
    return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
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
                SizedBox(height: 25.0),
                confirmPasswordField(),
                SizedBox(
                  height: 35.0,
                ),
                registerButton(),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
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

  Widget confirmPasswordField() {
    return TextField(
      controller: _confirmPasswordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget registerButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        //minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {

          final signupCubit = context.read<SignupCubit>();
          if (_passwordController.text == _confirmPasswordController.text) {
            signupCubit.getSignup(_emailController.text, _passwordController.text);
          }
          else {
            signupCubit.emit(SignupError('Passwords do not match'));
          }
        },
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
