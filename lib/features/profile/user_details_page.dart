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

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _cellNumberFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  bool isNumeric(String str) {
    return num.tryParse(str) != null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Display success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Details saved successfully!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.teal[700], // Custom background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
          behavior: SnackBarBehavior.floating, // Floating SnackBar
          // action: SnackBarAction(
          //   label: 'Undo', // Action label
          //   textColor: Colors.amber, // Action text color
          //   onPressed: () {
          // Define what happens when action is pressed
          // For example, undo the save action
          //   },
          // ),
        ),
      );

      print('First name: ${_firstNameController.text}');
      print('Last name: ${_lastNameController.text}');
      print(
          'Cell number: ${_selectedCountryCode?.dialCode ?? ''} ${_cellNumberController.text}');
      print('Email: ${_emailController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
            color: Colors.white70,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
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
                      _buildCustomTextField(
                        controller: _firstNameController,
                        labelText: 'First Name',
                        hintText: 'Enter your first name',
                        icon: Icons.person,
                        focusNode: _firstNameFocus,
                        nextFocusNode: _lastNameFocus,
                      ),
                      const SizedBox(height: 16),
                      _buildCustomTextField(
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        hintText: 'Enter your last name',
                        icon: Icons.person_outline,
                        focusNode: _lastNameFocus,
                        nextFocusNode: _cellNumberFocus,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.35,
                            child: CountryCodePicker(
                              onChanged: (CountryCode countryCode) {
                                _selectedCountryCode = countryCode;
                              },
                              initialSelection: '+20',
                              showFlagDialog: true,
                              showDropDownButton: true,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildCustomTextField(
                              controller: _cellNumberController,
                              labelText: 'Cell Number',
                              hintText: 'Enter your cell number',
                              icon: Icons.phone,
                              focusNode: _cellNumberFocus,
                              nextFocusNode: _emailFocus,
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
                      _buildCustomTextField(
                        controller: _emailController,
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        icon: Icons.email,
                        focusNode: _emailFocus,
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
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 8.0,
                          backgroundColor: Colors.teal[700],
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
                                color: Colors.white70,
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

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.teal),
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
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        } else {
          FocusScope.of(context).unfocus(); // Dismiss keyboard if no next field
        }
      },
    );
  }
}
