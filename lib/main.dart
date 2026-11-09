import 'package:flutter/material.dart';

void main() {
  runApp(const LoginRegisterApp());
}

class LoginRegisterApp extends StatelessWidget {
  const LoginRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Activity 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 245, 138, 209),
          ),
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();

  bool _isLogin = true;
  bool _hidePassword = true;
  bool _isLoggedIn = false;

  String? _registeredName;
  String? _registeredEmail;
  String? _registeredPassword;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _clearFields() {
    _namecontroller.clear();
    _emailcontroller.clear();
    _passwordcontroller.clear();
    _confirmpasswordcontroller.clear();

  }

  void _switchForm() {
    setState(() {
    _formKey.currentState!.reset();
    _clearFields();

      setState(() {
        _isLogin = !_isLogin;
        _hidePassword = true;
      
    });
    
  });
  }
  void submitForm() {
    if (!_formKey.currentState!.validate()) {
      final email = _emailcontroller.text.trim().toLowerCase();
    }
  final password = _passwordcontroller.text;

  if (_isLogin) {
    if (_registeredEmail == null) {
      _showMessage('Please register an account first.');
      return;
    }

    if (_registeredEmail !=  _registeredEmail || password != _registeredPassword) {
      _showMessage('Incorrect email or password.');
      return;
    }

    _clearFields();

    setState(() {
      _isLoggedIn = true;
    });
  } else {
    if (_registeredEmail != null) {
      _showMessage('An account already exist. Please log in.');
      return;
    }

    _registeredName = _namecontroller.text.trim();
    _registeredEmail = _emailcontroller.text.trim().toLowerCase();
    _registeredPassword = _passwordcontroller.text;

    _formKey.currentState!.reset();
    _clearFields();

    setState(() {
      _isLogin = true;
      _hidePassword = true;
    });

    _showMessage('Registration successful. Please log in.');

  }
  }

  void logout() {
    setState(() {
      _isLoggedIn = false;
      _isLogin = true;
      _hidePassword = true;
    });
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return Scaffold (
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome, $_registeredName!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    
                  ),
              ),
              const SizedBox(height: 8),
              Text(_registeredEmail ?? ''),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: logout,
                child: const Text('Logout'),
              ),
                ],
                ),
          ),
      ),
      );
        
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
      ),

    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: 
          CrossAxisAlignment.stretch,
          children: [
            const Text(
              'ChelLive',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
              const SizedBox(height: 12),

            const Icon(
              Icons.account_circle,
              size: 80,
              color: Colors.pinkAccent,
            ),
            const SizedBox(height: 16),
            Text(
              _isLogin ? 'Welcome Back!' : 'Create an Account',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            if (!_isLogin) ...[
              TextFormField(
                controller: _namecontroller,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
          ],

          TextFormField(
            controller: _emailcontroller,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordcontroller,
            obscureText: _hidePassword,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _hidePassword 
                  ? Icons.visibility 
                  : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 8) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),
          if (!_isLogin) ...[
            TextFormField(
              controller: _confirmpasswordcontroller,
              obscureText: _hidePassword,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordcontroller.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
          ],

          ElevatedButton(
            onPressed: submitForm,
            child: Text(_isLogin ? 'Login' : 'Register',
            ),
          ),
          const SizedBox(height: 8),

          TextButton(
            onPressed: _switchForm,
            child: Text(_isLogin 
            ? 'Don\'t have an account? Register' 
            : 'Already have an account? Login',
            ),
          ),

          const SizedBox(height: 32),

          const Divider(),
            const SizedBox(height: 8),
            const Text(
              'Developer: Michelle Banico\nSection: CCE106L(3450)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ), 
            )

          
          
          ],
          ),
        ),
      ),
    ),
    );

}

}