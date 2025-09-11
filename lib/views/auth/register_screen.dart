import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../viewmodels/register_view_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<RegisterViewModel>(
          builder: (context, viewModel, _) {
            return SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildProgressIndicator(viewModel),
                      const SizedBox(height: 20),
                      if (viewModel.currentStep == 0)
                        _buildGeneralDetailsStep(viewModel)
                      else
                        _buildVerificationStep(viewModel),
                      const SizedBox(height: 20),
                      _buildBottomSection(viewModel),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(RegisterViewModel viewModel) {
    return Row(
      children: [
        _buildStepCircle(1, viewModel.currentStep >= 0, 'General\nDetails'),
        Expanded(child: Container(height: 2, color: Colors.grey.shade300)),
        _buildStepCircle(2, viewModel.currentStep >= 1, 'Number\nVerification'),
      ],
    );
  }

  Widget _buildStepCircle(int step, bool isActive, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: isActive ? Colors.deepOrange : Colors.grey,
          child: Text(
            step.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? Colors.deepOrange : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildGeneralDetailsStep(RegisterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          label: 'First Name *',
          controller: viewModel.firstNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter first name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Last Name *',
          controller: viewModel.lastNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter last name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Phone Number *',
          controller: viewModel.phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter phone number';
            }
            if (value.length != 10) {
              return 'Phone number must be 10 digits';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Email (Optional)',
          controller: viewModel.emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              final bool emailValid = RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              ).hasMatch(value);
              if (!emailValid) {
                return 'Please enter a valid email address';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Labour Contractor ID (Optional)',
          controller: viewModel.labourContractorIdController,
        ),
        const SizedBox(height: 16),
        if (!viewModel.isOtpSent)
          CustomButton(
            title: viewModel.isLoading ? 'Sending...' : 'VERIFY PHONE',
            onPressed: viewModel.isLoading
                ? () {}
                : () {
                    if (_formKey.currentState?.validate() ?? false) {
                      viewModel.verifyPhoneNumber();
                    }
                  },
          )
        else
          Column(
            children: [
              CustomTextField(
                label: 'Enter OTP *',
                controller: viewModel.otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP';
                  }
                  if (value.length != 6) {
                    return 'OTP must be 6 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                title: viewModel.isLoading ? 'Verifying...' : 'VERIFY OTP',
                onPressed: viewModel.isLoading
                    ? () {}
                    : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          viewModel.verifyOtp();
                        }
                      },
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildVerificationStep(RegisterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDocumentUpload(
          'Aadhaar Card *',
          viewModel.aadharCard,
          (file) => setState(() => viewModel.aadharCard = file),
        ),
        const SizedBox(height: 16),
        _buildDocumentUpload(
          'PAN Card *',
          viewModel.panCard,
          (file) => setState(() => viewModel.panCard = file),
        ),
        const SizedBox(height: 16),
        _buildDocumentUpload(
          'Passport Size Photo *',
          viewModel.passportPhoto,
          (file) => setState(() => viewModel.passportPhoto = file),
        ),
        const SizedBox(height: 24),
        CustomButton(
          title: viewModel.isLoading ? 'Registering...' : 'REGISTER',
          onPressed: viewModel.isLoading || !viewModel.canSubmit
              ? () {}
              : () {
                  if (_formKey.currentState?.validate() ?? false) {
                    viewModel.register();
                  }
                },
        ),
      ],
    );
  }

  Widget _buildDocumentUpload(
    String label,
    File? file,
    Function(File?) onFilePicked,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _pickImage(onFilePicked),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: file != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(file, fit: BoxFit.cover),
                  )
                : const Icon(Icons.add_photo_alternate_outlined, size: 40),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(Function(File?) onFilePicked) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onFilePicked(File(image.path));
    }
  }

  Widget _buildBottomSection(RegisterViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
