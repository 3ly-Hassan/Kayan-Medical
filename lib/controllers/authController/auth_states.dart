abstract class AuthStates {}

class MedLoginInitialState extends AuthStates {}

class MedLoginLoadingState extends AuthStates {}

class MedLoginSuccessState extends AuthStates {
  // final LoginResponseModel loginModel;

  // MedLoginSuccessState(this.loginModel);
}

class MedLoginErrorState extends AuthStates {
  final String? error;

  MedLoginErrorState({this.error});
}

class LoginPageToggled extends AuthStates {}

class SelectState extends AuthStates {}

class MedChangePasswordVisibilityState extends AuthStates {}
