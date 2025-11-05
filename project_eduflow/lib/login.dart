
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;
  late AnimationController _anim;
  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _anim.forward();
  }
  @override
  void dispose() {
    _anim.dispose();
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }
  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => _loading = false);
    // Replace current (no back to login)
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFF3D6), Color(0xFFFBF0E0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Decorative soft shapes using Positioned Containers
          Positioned(
            top: -size.width * 0.25,
            left: -size.width * 0.15,
            child: Transform.rotate(
              angle: -0.6,
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE9B8).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(220),
                ),
              ),
            ),
          ),
          Positioned(
            right: -size.width * 0.2,
            bottom: -size.width * 0.2,
            child: Container(
              width: size.width * 0.9,
              height: size.width * 0.9,
              decoration: BoxDecoration(
                color: const Color(0xFFF7DFA2).withOpacity(0.8),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          // Content card
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: CurvedAnimation(parent: _anim, curve: Curves.easeIn),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          'EduFlow',
                          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Color(0xFF6B4C00)),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Welcome back — continue your learning journey',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 28),
                        // Form card
                        Material(
                          elevation: 6,
                          borderRadius: BorderRadius.circular(22),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: const LinearGradient(
                                colors: [Colors.white, Color(0xFFFFF8EE)],
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _email,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person_outline),
                                      labelText: 'Email',
                                      border: InputBorder.none,
                                    ),
                                    validator: (v) {
                                      if (v == null || v.trim().isEmpty) return 'Enter email';
                                      if (!v.contains('@')) return 'Invalid email';
                                      return null;
                                    },
                                  ),
                                  const Divider(),
                                  TextFormField(
                                    controller: _pass,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.lock_outline),
                                      labelText: 'Password',
                                      border: InputBorder.none,
                                    ),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) return 'Enter password';
                                      if (v.length < 4) return 'Too short';
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  SizedBox(
                                    width: double.infinity,
                                    child: AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 400),
                                      child: _loading
                                          ? const Center(key: ValueKey(1), child: CircularProgressIndicator())
                                          : ElevatedButton(
                                              key: const ValueKey(2),
                                              style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(vertical: 14),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                backgroundColor: const Color(0xFFD99B2B),
                                              ),
                                              onPressed: _submit,
                                              child: const Text('Login', style: TextStyle(fontSize: 16)),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () => _email.clear(),
                                        child: const Text('Clear', style: TextStyle(color: Colors.black54)),
                                      ),
                                      const SizedBox(width: 6),
                                      TextButton(
                                        onPressed: () {
                                          // demo navigate to dashboard directly as alternative
                                          Navigator.of(context).pushReplacementNamed('/dashboard');
                                        },
                                        child: const Text('Continue as guest', style: TextStyle(color: Colors.black54)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text('By continuing you agree to the terms and privacy.',
                            style: TextStyle(fontSize: 12, color: Colors.black54), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
