import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildFaqItem(
            'How do I register as a labour contractor?',
            'To register, click on the "Register" button on the login screen. Fill in your details and submit the required documents. Our team will verify your information and activate your account.',
          ),
          _buildFaqItem(
            'How do I update my profile information?',
            'Go to Profile in the menu and tap on the edit icon. You can update your personal information, contact details, and upload new documents there.',
          ),
          _buildFaqItem(
            'How do I manage my labour workforce?',
            'Use the Labour Management section to add new labourers, update their details, and track their assignments to different orders.',
          ),
          _buildFaqItem(
            'How do payments work?',
            'Payments are processed through our secure payment gateway. You will receive payments for completed orders directly to your registered bank account.',
          ),
          _buildFaqItem(
            'What documents are required for registration?',
            'Required documents include Aadhaar Card, PAN Card, and Business License. Additional documents may be required based on your location and type of work.',
          ),
          _buildFaqItem(
            'How do I contact support?',
            'You can reach our support team through the Help & Support section in the app or email us at support@roadferry.com.',
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
