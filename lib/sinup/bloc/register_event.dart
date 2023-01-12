part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class SignUpEvent extends RegisterEvent {
  SignUpEvent(
      {required this.email, required this.password, required this.username});
  String email;
  String password;
  String username;
}
