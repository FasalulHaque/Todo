import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/homescreen/home.dart';
import 'package:todo/login/login.dart';
import 'package:todo/splash_screen/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final _splashBloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _splashBloc..add(NavigateToLoginEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          //print(state);
          if (state is NavigateToHomeState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),);
          }
        },
        child: const Scaffold(
          body: Center(
            child: Text(
              'WELCOME',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
