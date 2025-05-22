// signup_multi_step_screen.dart
import 'package:e_marketplace_app/features/presentation/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum SignupMethod { email, phone }

class SignupMultiStepScreen extends StatefulWidget {
  const SignupMultiStepScreen({Key? key}) : super(key: key);

  @override
  _SignupMultiStepScreenState createState() => _SignupMultiStepScreenState();
}

class _SignupMultiStepScreenState extends State<SignupMultiStepScreen> {
  int _currentStep = 0;
  SignupMethod? _chosenMethod;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verificationCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  File? _profileImage;

  final GlobalKey<FormState> _step0FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step2FormKey = GlobalKey<FormState>();

  final String _simulatedCorrectCode = "123456"; // Simulated code
  bool _isCodeSent = false; // Flag to track if code simulation finished

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _verificationCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // --- Image Picking Logic (Same as before) ---
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Step Navigation Logic ---
  void _nextStep() {
    // When _nextStep is called by the *main* button, validate the current step
    bool isStepValid = false;
    if (_currentStep == 0) {
       // Step 0 navigation is handled by _sendVerificationCode after validation
       // This path should ideally not be hit by the main "Next" button directly anymore
       isStepValid = _chosenMethod != null;
    } else if (_currentStep == 1) {
      // Validation for verification code input happens here when 'Next' is pressed on Step 1
      isStepValid = _step1FormKey.currentState!.validate();

      if (isStepValid) {
         // --- Frontend Only Verification Simulation ---
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Verifying Code...')),
         );

         Future.delayed(const Duration(seconds: 2), () {
           if (mounted) {
             if (_verificationCodeController.text == _simulatedCorrectCode) {
               print('Code verification successful.');
                ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Verification Successful!')),
                 );
               // Proceed to the next step on success
                setState(() {
                  _currentStep++;
                });
             } else {
                print('Code verification failed.');
                ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Invalid verification code. Please try again.')),
                 );
                _verificationCodeController.clear();
             }
           }
         });
         return;
      }
       return;
    } else if (_currentStep == 2) {
      // Validate password and confirm password
      isStepValid = _step2FormKey.currentState!.validate();
    } else if (_currentStep == 3) {
      // Profile Photo step
      isStepValid = true;
    }

    // If validation passed (or no validation needed) and not the last step
    if (isStepValid && _currentStep < _signupSteps().length - 1) {
      setState(() {
        _currentStep++;
      });
    } else if (isStepValid && _currentStep == _signupSteps().length - 1) {
      // Last step, perform final signup
      _performSignup();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
         if (_currentStep == 1) {
            _isCodeSent = false;
            _verificationCodeController.clear();
         }
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // --- Simulated Actions for Verification Step ---
  void _sendVerificationCode() {
    if (_step0FormKey.currentState!.validate()) {
      String target = '';
      if (_chosenMethod == SignupMethod.email) {
        target = _emailController.text;
        print('Simulating sending email verification code to: $target');
      } else if (_chosenMethod == SignupMethod.phone) {
        target = _phoneController.text;
        print('Simulating sending SMS verification code to: $target');
      } else {
         print('Error: Method not chosen for sending code.');
         return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sending verification code to $target... (Simulated)')),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification code sent! (Simulated) Code is $_simulatedCorrectCode')),
          );
          setState(() {
            _isCodeSent = true;
             _currentStep++; // Auto-move to Step 1 after sending
          });
        }
      });
    }
  }


  // --- Final Signup Action (Simulated - Same as before) ---
  void _performSignup() {
    print('Performing Signup with collected data:');
    print('Method: ${_chosenMethod == SignupMethod.email ? 'Email' : 'Phone'}');
    if (_chosenMethod == SignupMethod.email) {
       print('Email: ${_emailController.text}');
    } else {
       print('Phone: ${_phoneController.text}');
    }
    print('Password (hashed backend-side): ${_passwordController.text}');
    print('Profile Image Selected: ${_profileImage != null}');
    if (_profileImage != null) {
      print('Profile Image Path: ${_profileImage!.path}');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registering User...')),
    );

    Future.delayed(const Duration(seconds: 3), () {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Signup Successful! (Simulated)')),
       );
       Navigator.pop(context);
    });
  }

  // --- Social Signup Simulation (Same as before) ---
   void _signupWithGoogle() {
     print('Attempting Google Signup');
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Initiating Google Sign-Up (Simulated)...')),
    );
  }

  void _signupWithFacebook() {
    print('Attempting Facebook Signup');
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Initiating Facebook Sign-Up (Simulated)...')),
    );
  }


  // --- Define the list of signup steps/widgets ---
  List<Widget> _signupSteps() {
    Widget _buildEmailPhoneInput() {
       if (_chosenMethod == SignupMethod.email) {
         return TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
             validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
               if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                 return 'Please enter a valid email address';
              }
              return null;
            },
            onChanged: (value) => setState(() {}),
          );
       } else if (_chosenMethod == SignupMethod.phone) {
          return TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              hintText: 'Phone Number',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
             validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
               if (!RegExp(r'^\+?[0-9]{10,}$').hasMatch(value)) {
                  return 'Please enter a valid phone number';
               }
              return null;
            },
            onChanged: (value) => setState(() {}),
          );
       } else {
         return Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             ElevatedButton.icon(
               icon: const Icon(Icons.email_outlined),
               label: const Text('Sign up with Email'),
               onPressed: () {
                 setState(() {
                   _chosenMethod = SignupMethod.email;
                    _isCodeSent = false;
                    _emailController.clear();
                    _phoneController.clear();
                    _verificationCodeController.clear();
                 });
               },
             ),
             const SizedBox(height: 16),
             ElevatedButton.icon(
                icon: const Icon(Icons.phone_outlined),
                label: const Text('Sign up with Phone Number'),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.grey[300],
                   foregroundColor: Colors.black,
                 ),
                onPressed: () {
                  setState(() {
                    _chosenMethod = SignupMethod.phone;
                    _isCodeSent = false;
                     _emailController.clear();
                    _phoneController.clear();
                     _verificationCodeController.clear();
                  });
                },
              ),
              const SizedBox(height: 24),
               Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR', style: TextStyle(color: Colors.grey[600])),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
               // Social Login Buttons
               OutlinedButton.icon(
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Continue with Google'),
                 style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                     side: BorderSide(color: Colors.grey[400]!),
                  ),
                onPressed: _signupWithGoogle,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                 icon: const Icon(Icons.facebook),
                 label: const Text('Continue with Facebook'),
                 style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                     side: BorderSide(color: Colors.grey[400]!),
                  ),
                onPressed: _signupWithFacebook,
              ),
           ],
         );
       }
    }

    return [
      // Step 0: Email/Phone Selection and Input
      Form(
        key: _step0FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _chosenMethod == null ? 'Choose Signup Method' : 'Enter Your ${_chosenMethod == SignupMethod.email ? 'Email' : 'Phone Number'}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildEmailPhoneInput(),
             if (_chosenMethod != null) ...[
               const SizedBox(height: 24),
               ElevatedButton(
                 onPressed: (_chosenMethod == SignupMethod.email && _emailController.text.isNotEmpty) ||
                            (_chosenMethod == SignupMethod.phone && _phoneController.text.isNotEmpty)
                             ? _sendVerificationCode
                             : null,
                 child: Text('Send Verification Code via ${_chosenMethod == SignupMethod.email ? 'Email' : 'SMS'}'),
               ),
             ],
          ],
        ),
      ),

      // Step 1: Verification Code
      Form(
        key: _step1FormKey,
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Verify Your Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Enter the code sent to your ${_chosenMethod == SignupMethod.email ? 'email address' : 'phone number'}.',
               textAlign: TextAlign.center,
               style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
             const SizedBox(height: 16),
            TextFormField(
              controller: _verificationCodeController,
              decoration: const InputDecoration(
                hintText: 'Verification Code',
                 prefixIcon: Icon(Icons.vpn_key_outlined),
              ),
              keyboardType: TextInputType.number,
               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the verification code';
                }
                 if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Invalid code format (digits only)';
                 }
                 if (value.length != _simulatedCorrectCode.length) {
                    return 'Code must be exactly ${_simulatedCorrectCode.length} digits';
                 }
                return null;
              },
              // ADDED: Trigger rebuild on text change
              onChanged: (value) {
                // Manually trigger validation check and rebuild
                _step1FormKey.currentState?.validate();
                setState(() {}); // Rebuild to update button state
              },
            ),
             const SizedBox(height: 16),
             TextButton(
               onPressed: _sendVerificationCode,
               child: const Text('Resend Code'),
             ),
          ],
        ),
      ),

      // Step 2: Password Creation
      Form(
        key: _step2FormKey,
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create Your Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                 if (value.length < 6) {
                   return 'Password must be at least 6 characters';
                 }
                return null;
              },
              // <-- ADDED: Trigger rebuild on text change
              onChanged: (value) {
                 _step2FormKey.currentState?.validate(); // Optional: Trigger immediate validation feedback
                 setState(() {}); // Rebuild to update button state
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                 if (value != _passwordController.text) {
                   return 'Passwords do not match';
                 }
                return null;
              },
               // <-- ADDED: Trigger rebuild on text change
              onChanged: (value) {
                 _step2FormKey.currentState?.validate(); // Optional: Trigger immediate validation feedback
                 setState(() {}); // Rebuild to update button state
              },
            ),
          ],
        ),
      ),

      // Step 3: Profile Photo (Same as before)
      Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add a Profile Photo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: GestureDetector(
              onTap: _showImagePickerOptions,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[300],
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : null,
                child: _profileImage == null
                    ? Icon(Icons.camera_alt_outlined, size: 50, color: Colors.grey[700])
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 16),
           TextButton(
             onPressed: _showImagePickerOptions,
             child: Text(_profileImage == null ? 'Choose Profile Photo' : 'Change Profile Photo'),
           ),
           const SizedBox(height: 24),
           const Text(
              'You can add or change this later in your profile settings.',
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: 14.0, color: Colors.grey),
           )
        ],
      ),
    ];
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    final steps = _signupSteps();

    return Scaffold(
      appBar: TransparentAppBar(
        title: Text('Sign Up (Step ${_currentStep + 1} of ${steps.length})'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _previousStep,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: steps[_currentStep],
                ),
              ),
              const SizedBox(height: 24),

              // Navigation Buttons Row
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Back Button
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                         style: OutlinedButton.styleFrom(
                           padding: const EdgeInsets.symmetric(vertical: 16.0),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8.0),
                           ),
                            side: BorderSide(color: Colors.grey[400]!),
                         ),
                        onPressed: _previousStep,
                        child: const Text('Back'),
                      ),
                    ),
                   if (_currentStep > 0 &&
                       (_currentStep < steps.length - 1 ||
                       (_currentStep == steps.length - 1 && _currentStep > 0)))
                       const SizedBox(width: 16),

                  // Next / Sign Up Button
                   if (_currentStep > 0 || (_currentStep == 0 && _chosenMethod != null))
                   Expanded(
                     child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           padding: const EdgeInsets.symmetric(vertical: 16.0),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8.0),
                           ),
                         ),
                        // Button enabling logic:
                        onPressed:
                          (_currentStep == 0 && _chosenMethod != null && !_isCodeSent) // Disabled on Step 0 after method chosen, before code sent
                           ? null
                           : (_currentStep == 0 && _isCodeSent) // Enabled on Step 0 AFTER code sent (should auto-move)
                               ? _nextStep
                           : (_currentStep == 1 && _isCodeSent && _step1FormKey.currentState?.validate() == true) // Enabled on Step 1 IF code sent AND input valid
                               ? _nextStep
                           : (_currentStep == 2 && _step2FormKey.currentState?.validate() == true) // <-- CORRECTED: Check Step 2 validation
                                   ? _nextStep
                                   : (_currentStep == 3) // Always enabled on Step 3 (Signup button)
                                       ? _nextStep
                                       : null, // Disabled otherwise


                       child: Text(_currentStep < steps.length - 1 ? 'Next' : 'Sign Up'),
                     ),
                   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}