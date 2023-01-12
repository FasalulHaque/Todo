import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/shared_prefirepo/shared_prefirepo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          final auth = FirebaseAuth.instance;
          try {
            await auth.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            await SharedPerf().setUserData(event.email, auth.currentUser!.uid);

            emit(LoginSuccess());
          } on FirebaseAuthException catch (e) {
            emit(
              LoginFailed(
                message: e.code,
              ),
            );
          }
        }
        // void onEvent(AuthenticationEvent event) {
        //   super.onEvent(event);
        //   print('The event is......................$event');
        // }

        onEvent(event);
        void onTransition(
          Transition<AuthenticationEvent, AuthenticationState> transition,
        ) {
          super.onTransition(transition);
        }

        onTransition(
          Transition(
            currentState: this.state,
            event: event,
            nextState: state,
          ),
        );
      },
    );
  }
}
