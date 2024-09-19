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
        backgroundColor: Colors.blueGrey[900],
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
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
              subtitle: 'Get notified about upcoming appointments and offers.',
              value: _pushNotifications,
              onChanged: (value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
            ),
            _buildPreferenceTile(
              title: 'Medical Data Consent',
              subtitle: 'Consent to share medical data for tailored services.',
              value: _medicalDataConsent,
              onChanged: (value) {
                setState(() {
                  _medicalDataConsent = value;
                });
              },
            ),
            const SizedBox(height: 5),
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
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.blueAccent,
                      ),
                ),
              ),
            ),
          ],
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
      margin: const EdgeInsets.symmetric(vertical: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
