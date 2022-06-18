import 'package:flutter/material.dart';
import 'package:order_app_client/features/customer/domain/usecase/login.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';

class LoginViewModel extends ChangeNotifier {
  LoginUseCase usecase = getIt<LoginUseCase>();

  String _email = "";
  String _password = "";
  bool _isLoading = false;
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  GlobalKey<FormState> get formState => _formState;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setFormState(GlobalKey<FormState> formState) {
    _formState = formState;
    notifyListeners();
  }

  void clear() {
    _email = "";
    _password = "";
    _isLoading = false;
    notifyListeners();
  }

  String? isValidPassword(String? value) {
    if (value!.trim().isEmpty) {
      return "This field is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  String? isValidEmail(String? email) {
    if (email!.trim().isEmpty) {
      return "This field is required";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.toString())) {
      return "Please enter a valid email";
    }
    return null;
  }

  Future<bool> doLogin() {
    setIsLoading(true);
    return usecase.doLogin(email, password);
  }
}
