import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/shared_prefirepo/shared_prefirepo.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>(
      (event, emit) async {
        //print(event);

        if (event is NavigateToLoginEvent) {
          await Future.delayed(const Duration(seconds: 3));
          final data = await SharedPerf().getUserData();
          if (data['isLogin'] == true) {
            emit(NavigateToHomeState());
          } else {
            emit(NavigateToLoginState());
          }
        }
      },
    );
  }
}
