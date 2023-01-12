import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is SignUpEvent) {
        final auth = FirebaseAuth.instance;
        final userRef = FirebaseFirestore.instance.collection('users');
        try {
          await auth.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          await userRef.doc(auth.currentUser!.uid).set({
            'userid': auth.currentUser!.uid,
            'userName': event.username,
            'email': event.email,
            'password': event.password,
            'profileImage': ''
          });
          SingUpSuccess();
        } on FirebaseAuthException catch (e) {
          emit(SingUpFailed(errMessage: e.code));
        }
      }
    });
  }
}
