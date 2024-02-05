

abstract class AuthState {}

class AuthInitial extends AuthState {}



///LoginState
class LoadingLoginState extends AuthState {}
class SuccessfulLoginState extends AuthState {}
class ErrorLoginState extends AuthState {}



///LoginState
class LoadingRegisterState extends AuthState {}
class SuccessfulRegisterState extends AuthState {}
class ErrorRegisterState extends AuthState {}

///SignOut State
class LoadingSignOutState extends AuthState {}
class SuccessfulSignOutState extends AuthState {}
class ErrorSignOutState extends AuthState {}