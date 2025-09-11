import 'package:flutter/material.dart';
import 'dart:io';

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController labourContractorIdController =
      TextEditingController();

  File? aadharCard;
  File? panCard;
  File? passportPhoto;

  bool isLoading = false;
  bool isOtpSent = false;
  int currentStep = 0;

  bool get isFirstStepValid {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        phoneController.text.length == 10;
  }

  bool get isSecondStepValid {
    return isOtpSent && otpController.text.length == 6;
  }

  bool get canSubmit {
    return isFirstStepValid &&
        isSecondStepValid &&
        aadharCard != null &&
        panCard != null &&
        passportPhoto != null;
  }

  Future<void> verifyPhoneNumber() async {
    if (phoneController.text.length != 10) return;

    setLoading(true);
    // TODO: Implement phone verification logic
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    isOtpSent = true;
    setLoading(false);
    notifyListeners();
  }

  Future<void> verifyOtp() async {
    if (otpController.text.length != 6) return;

    setLoading(true);
    // TODO: Implement OTP verification logic
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    if (currentStep < 1) currentStep = 1;
    setLoading(false);
    notifyListeners();
  }

  Future<void> register() async {
    if (!canSubmit) return;

    setLoading(true);
    // TODO: Implement registration logic
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    setLoading(false);
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    otpController.dispose();
    labourContractorIdController.dispose();
    super.dispose();
  }
}
