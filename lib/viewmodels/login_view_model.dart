import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login() async {
    if (phoneController.text.isEmpty || phoneController.text.length != 10) {
      return;
    }

    setLoading(true);

    // TODO: Implement login logic here
    await Future.delayed(const Duration(seconds: 2)); // Simulating API call

    setLoading(false);
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
