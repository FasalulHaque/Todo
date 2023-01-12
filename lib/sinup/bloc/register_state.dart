part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class SingUpSuccess extends RegisterState {}

class SingUpFailed extends RegisterState {
  SingUpFailed({required this.errMessage});
    String errMessage;
  
}
