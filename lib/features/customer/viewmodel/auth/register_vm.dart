import 'package:flutter/material.dart';
import 'package:order_app_client/features/customer/domain/usecase/register.dart';
import 'package:order_app_client/infrastructure/dependency_injection/injection.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterUseCase useCase = getIt<RegisterUseCase>();

  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _name = "";
  String _confirmPassword = "";
  String _phoneNumber = "";
  bool _isLoading = false;

  GlobalKey<FormState> get formState => _formState;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get name => _name;
  String get phoneNumber => _phoneNumber;
  bool get isLoading => _isLoading;

  void setGlobalKey(GlobalKey<FormState> formState) {
    _formState = formState;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String? isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "This field is required";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.toString())) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? isValidPassword(String? password) {
    if (password == null || password.isEmpty) {
      return "This field is required";
    }
    if (password.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  String? isValidConfirmPassword(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "This field is required";
    }
    if (confirmPassword != _password) {
      return "Password does not match";
    }
    return null;
  }

  Future<bool> register() {
    setIsLoading(true);
    return useCase.register(
      email: _email,
      password: _password,
      name: _name,
      phoneNumber: _phoneNumber,
    );
  }
}
