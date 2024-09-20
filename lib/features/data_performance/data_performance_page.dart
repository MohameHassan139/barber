import 'package:barber/features/data_performance/PrivacyPolicyPage.dart';
import 'package:flutter/material.dart';

class DataPreferencesPage extends StatefulWidget {
  const DataPreferencesPage({super.key});

  @override
  State<DataPreferencesPage> createState() => _DataPreferencesPageState();
}

class _DataPreferencesPageState extends State<DataPreferencesPage> {
  bool _receiveMarketingEmail = true;
  bool _receiveMarketingSMS = true;
  bool _receiveSatisfactionSurveys = false;
  bool _pushNotifications = true;
  bool _medicalDataConsent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Preferences'),
        backgroundColor: Colors.teal[700], // Change to a calm color
        elevation: 8,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[100]!, Colors.teal[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              _buildPreferenceTile(
                title: 'Receive Marketing Email',
                subtitle: 'Stay updated with promotional offers via email.',
                value: _receiveMarketingEmail,
                onChanged: (value) {
                  setState(() {
                    _receiveMarketingEmail = value;
                  });
                },
              ),
              _buildPreferenceTile(
                title: 'Receive Marketing SMS',
                subtitle: 'Receive SMS notifications for exclusive offers.',
                value: _receiveMarketingSMS,
                onChanged: (value) {
                  setState(() {
                    _receiveMarketingSMS = value;
                  });
                },
              ),
              _buildPreferenceTile(
                title: 'Receive Satisfaction Surveys',
                subtitle: 'Provide feedback to improve our services.',
                value: _receiveSatisfactionSurveys,
                onChanged: (value) {
                  setState(() {
                    _receiveSatisfactionSurveys = value;
                  });
                },
              ),
              _buildPreferenceTile(
                title: 'Push Notifications',
                subtitle:
                    'Get notified about upcoming appointments and offers.',
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
              ),
              _buildPreferenceTile(
                title: 'Medical Data Consent',
                subtitle:
                    'Consent to share medical data for tailored services.',
                value: _medicalDataConsent,
                onChanged: (value) {
                  setState(() {
                    _medicalDataConsent = value;
                  });
                },
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const PrivacyPolicyPage(),
                    );
                  },
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.teal[800], // Darker text for visibility
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(7),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.teal[900], // Dark text for better readability
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.teal[800]), // Subtle color
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.teal[600], // Active switch color
        ),
      ),
    );
  }
}
