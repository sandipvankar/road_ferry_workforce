import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.deepOrange.shade50,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/images/profile_placeholder.png',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Labour Contractor',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection('Contact Information', [
                    _buildInfoItem(Icons.phone, 'Phone', '+91 9876543210'),
                    _buildInfoItem(
                      Icons.email,
                      'Email',
                      'john.doe@example.com',
                    ),
                    _buildInfoItem(
                      Icons.location_on,
                      'Address',
                      '123 Main Street, City, State',
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildInfoSection('Business Information', [
                    _buildInfoItem(Icons.badge, 'Contractor ID', 'LC123456'),
                    _buildInfoItem(Icons.group, 'Total Labourers', '50'),
                    _buildInfoItem(Icons.work, 'Completed Orders', '150+'),
                  ]),
                  const SizedBox(height: 24),
                  _buildInfoSection('Documents', [
                    _buildDocumentItem('Aadhaar Card', true),
                    _buildDocumentItem('PAN Card', true),
                    _buildDocumentItem('Business License', true),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
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
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String name, bool isVerified) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.description, color: Colors.deepOrange),
      title: Text(name),
      trailing: Icon(
        isVerified ? Icons.verified : Icons.warning,
        color: isVerified ? Colors.green : Colors.orange,
      ),
    );
  }
}
