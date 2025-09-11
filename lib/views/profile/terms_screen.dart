import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Introduction',
              'Welcome to Road Ferry Labour Contractor App. By using our app, you agree to these terms and conditions.',
            ),
            _buildSection(
              'User Registration',
              'Users must provide accurate information during registration. You are responsible for maintaining the confidentiality of your account.',
            ),
            _buildSection(
              'Services',
              'We provide a platform connecting labour contractors with job opportunities. We do not employ labourers directly.',
            ),
            _buildSection(
              'Payments',
              'All payments must be processed through our secure payment gateway. Service fees and commissions apply as per current rates.',
            ),
            _buildSection(
              'User Conduct',
              'Users must follow all applicable laws and regulations. Harassment, fraud, or misuse of the platform is strictly prohibited.',
            ),
            _buildSection(
              'Privacy',
              'We collect and process personal data as described in our Privacy Policy. Your data security is important to us.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }
}
