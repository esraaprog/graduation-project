import 'package:flutter/material.dart';
import 'package:graduation_project/models/defultPasswordTextform.dart';
import 'package:graduation_project/models/textformlogin.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  // String _selectedRole = 'Patient';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF8B4513), // Saddle brown
              const Color(0xFFD2691E), // Chocolate
              const Color(0xFFCD853F), // Peru
              const Color(0xFF8B6914), // Dark goldenrod
            ],
          ),
        ),
        child: Stack(
          children: [
            // Falling leaves animation background
            Positioned(
              top: 50,
              right: 20,
              child: _buildFallingLeaf('📢', 60, 0.7),
            ),
            Positioned(
              top: 150,
              left: 30,
              child: _buildFallingLeaf('⏰', 50, 0.5),
            ),
            Positioned(
              top: 300,
              right: 40,
              child: _buildFallingLeaf('🍂', 55, 0.6),
            ),
            Positioned(
              bottom: 200,
              left: 50,
              child: _buildFallingLeaf('⏳', 45, 0.4),
            ),
            // Main content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      // Header
                      Center(
                        child: Column(
                          children: [
                            Text('⏳', style: TextStyle(fontSize: 80)),
                            const SizedBox(height: 16),
                            const Text(
                              'Smart Medication Reminder',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      // Login form
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Email field
                              const Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8B4513),
                                ),
                              ),

                              const SizedBox(height: 8),
                              defultTextFormLogin(
                                controller: _emailController,
                                hittext: 'your email',
                                keyboardType: TextInputType.emailAddress,
                                validated: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                prifixIcon: Icons.email_outlined,
                              ),
                              const SizedBox(height: 20),
                              // Password field
                              const Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8B4513),
                                ),
                              ),
                              const SizedBox(height: 8),

                              DefultPasswordTextForm(
                                controller: _passwordController,
                                isPasswordVisible: _isPasswordVisible,
                                validated: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },

                                suffixIcon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFFD2691E),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              const SizedBox(height: 12),

                              // Forgot password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Handle forgot password
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: Color(0xFFD2691E),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Role selection
                              // const Text(
                              //   'يرجى تحديد الصفة',
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.w600,
                              //     color: Color(0xFF8B4513),
                              //   ),
                              // ),
                              // const SizedBox(height: 8),
                              // DropdownButtonFormField<String>(
                              //   value: _selectedRole,
                              //   decoration: InputDecoration(
                              //     contentPadding: const EdgeInsets.symmetric(
                              //       horizontal: 12,
                              //       vertical: 14,
                              //     ),
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //   ),
                              //   items: const [
                              //     DropdownMenuItem(
                              //       value: 'دكتور',
                              //       child: Text('دكتور'),
                              //     ),
                              //     DropdownMenuItem(
                              //       value: 'مريض',
                              //       child: Text('مريض'),
                              //     ),
                              //     DropdownMenuItem(
                              //       value: 'مساعد',
                              //       child: Text("مساعد"),
                              //     ),
                              //   ],
                              //   onChanged: (val) {
                              //     if (val == null) return;
                              //     setState(() {
                              //       _selectedRole = val;
                              //     });
                              //   },
                              // ),
                              const SizedBox(height: 20),
                              // Login button
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD2691E),
                                    disabledBackgroundColor: const Color(
                                      0xFFD2691E,
                                    ).withOpacity(0.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5,
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Sign up link
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        
                                           
                                        text: 'Sign up',
                                        style: const TextStyle(
                                          color: Color(0xFFD2691E),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        recognizer: null, // Add navigation here
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallingLeaf(String emoji, double size, double opacity) {
    return Opacity(
      opacity: opacity,
      child: Text(emoji, style: TextStyle(fontSize: size)),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return; // إذا في خطأ، وقف
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  // Future<void> _handleLogin() async {
  //   if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please fill in all fields'),
  //         backgroundColor: Color(0xFFD2691E),
  //       ),
  //     );
  //     return;
  //   }

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   // Simulate login
  //   await Future.delayed(const Duration(seconds: 2));

  //   setState(() {
  //     _isLoading = false;
  //   });

  //   if (mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Login successful!'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const HomeScreen()),
  //     );
  //   }
  // }
}
