import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Your privacy is important to us. Belliata and Zolmi are committed to respecting your privacy regarding any information we may collect while operating our websites. We have developed this Policy to help you understand how we collect, use, communicate, disclose, and make use of personal information. We comply with both the European Data Protection Directive and the ePrivacy Directive. The following outlines our privacy policy.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'When collecting your data:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'Before or at the time of collecting personal or business information, we will identify the purposes for which information is being collected. This may be found via our Cookies Policy and/or Terms & Conditions.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Why we collect data:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'We will collect and use personal or business information solely for the purpose of fulfilling those purposes specified by us and for other compatible purposes, unless we obtain the consent of the individual or business concerned or as required by law.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'We will never sell your data:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'Personal or business data will not be sold to third parties.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Collecting data with your prior knowledge or consent:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'We will collect personal or business information by lawful and fair means and, where appropriate, with the knowledge or consent of the individual concerned.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Collecting only relevant data:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'Personal or business data should be relevant to the purposes for which it is to be used, and, to the extent necessary for those purposes, should be accurate, complete, and up-to-date.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Disclosure for legal reasons:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'We reserve the right to communicate your personal and business data to third parties making a legally compliant request for its disclosure.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'How long do we retain your data?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'We will only retain personal or business information as long as necessary for the fulfillment of those purposes.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Protecting your data:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'We will endeavor to protect personal or business information by reasonable security safeguards against loss or theft, as well as unauthorized access, disclosure, copying, use, or modification. Credit card or any other type of payment data is never held directly by Belliata and is held securely by a specialist payment processing company, details of which are available on request.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Aggregated business analyses:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'From time to time, we may provide anonymous aggregated data analyses of our users to potential partners and advertisers. This is to improve our user experience and develop a more relevant product. At no point, however, will we disclose individual user data.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Transparency:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'We will make readily available to users information about our policies and practices relating to the management of personal information.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Data access requests:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'European Economic Area Citizens residing in the European Economic Area are able to request a data access request at the cost of £10 GBP (or equivalent in local currency). We are not obliged to fulfill identical or similar requests unless reasonable time has elapsed between requests.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Processing of data:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'Personal or business data may be moved, stored, and/or processed outside of the legal jurisdiction of the user (for example, outside the European Economic Area). Belliata complies with the European Data Protection Directive and therefore any jurisdiction where data is stored or processed must comply with this Directive. Belliata UK will endeavor to restrict the storing or processing of data outside of the European Economic Area.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 16),
            Text(
              'Changes of business:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 8),
            Text(
              'If the assets of Belliata used to operate its business and/or service are acquired by a third party, we reserve the right to transfer personal and business data to the acquiring third party.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
