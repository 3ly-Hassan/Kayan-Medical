abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ProductsLoading extends HomeStates {}

class ProductsLoaded extends HomeStates {}

class TabChangedState extends HomeStates {}

class LogoutLoadding extends HomeStates {}

class LogoutSuccess extends HomeStates {}

class LogoutError extends HomeStates {
  final String? error;

  LogoutError({this.error});
}

class BodyChangedState extends HomeStates {}

class ChageCategory extends HomeStates {}

class AddAdress extends HomeStates {}

class ToggleAddAdress extends HomeStates {}
