import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cellNumberController = TextEditingController();
  final _emailController = TextEditingController();
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
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.cyanAccent],
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
                        controller: _firstNameController,
                        labelText: 'First Name',
                        hintText: 'Enter your first name',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),

                      // Last Name Field
                      _buildCustomTextField(
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        hintText: 'Enter your last name',
                        icon: Icons.person_outline,
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
                              controller: _cellNumberController,
                              labelText: 'Cell Number',
                              hintText: 'Enter your cell number',
                              icon: Icons.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your cell number';
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
                        controller: _emailController,
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        icon: Icons.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // Save Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('First name: ${_firstNameController.text}');
                            print('Last name: ${_lastNameController.text}');
                            print(
                                'Cell number: ${_selectedCountryCode?.dialCode ?? ''} ${_cellNumberController.text}');
                            print('Email: ${_emailController.text}');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 8.0,
                          backgroundColor: Colors.blueAccent,
                          shadowColor: Colors.cyanAccent,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.blueAccent, Colors.cyanAccent],
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
                                color: Colors.white,
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
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
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
}
