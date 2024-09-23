import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({
    super.key,
    required this.bio,
    required this.name,
    required this.phone,
  });
  final String phone;
  final String name;
  final String bio;
  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController phoneController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);

    bioController = TextEditingController(text: widget.bio);
    phoneController = TextEditingController(text: widget.phone);

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  CountryCode? _selectedCountryCode;

  bool isNumeric(String str) {
    return num.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Your Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white70, // Light gray text color for contrast
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.lightBlueAccent
            ], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // First Name Field
                      _buildCustomTextField(
                        controller: nameController,
                        labelText: 'First Name',
                        hintText: 'Enter your first name',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      // Phone Number with Country Code
                      Row(
                        children: [
                          SizedBox(
                            width: 140, // Adjust the width as needed
                            child: CountryCodePicker(
                              onChanged: (CountryCode countryCode) {
                                _selectedCountryCode = countryCode;
                              },
                              initialSelection: '+20', // Egypt's code
                              showFlagDialog: true,
                              showDropDownButton: true,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: _buildCustomTextField(
                              controller: phoneController,
                              labelText: 'phone Number',
                              hintText: 'Enter your phone number',
                              icon: Icons.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (!isNumeric(value)) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Email Field
                      _buildCustomTextField(
                        controller: bioController,
                        labelText: 'bio',
                        hintText: 'Enter your bio',
                        icon: Icons.ballot_rounded,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your bio';
                          }
                          // if (!RegExp(
                          //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                          //     .hasMatch(value)) {
                          //   return 'Please enter a valid bio';
                          // }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // Save Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            updateProfile();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 8.0,
                          backgroundColor:
                              Colors.teal[700], // Darker teal button
                          shadowColor: Colors.tealAccent[100],
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.teal, Colors.tealAccent],
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 150, minHeight: 50),
                            alignment: Alignment.center,
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70, // Light text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom TextField Builder
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.teal), // Teal icon color
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.teal, width: 2),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return 'Please enter $labelText';
            }
            return null;
          },
    );
  }

  void updateProfile() async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'name': nameController.text,
      'phone': phoneController.text,
      'bio': bioController.text,
    });
    Navigator.pop(context);
  }
}
