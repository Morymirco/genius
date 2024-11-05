import 'package:coursenligne/config/theme/theme.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String _passwordStrength = '';
  Color _strengthColor = Colors.grey;
  int _strengthLevel = 0;
  bool _isPasswordVisible = false;

  void _checkPasswordStrength(String password) {
    setState(() {
      if (password.isEmpty) {
        _strengthLevel = 0;
        _passwordStrength = '';
        _strengthColor = Colors.grey;
      } else if (password.length < 6) {
        _strengthLevel = 1;
        _passwordStrength = 'Faible';
        _strengthColor = Colors.red;
      } else if (password.length < 8) {
        _strengthLevel = 2;
        _passwordStrength = 'Moyen';
        _strengthColor = Colors.orange;
      } else {
        bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
        bool hasDigits = password.contains(RegExp(r'[0-9]'));
        bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
        
        if (hasUppercase && hasDigits && hasSpecialCharacters) {
          _strengthLevel = 3;
          _passwordStrength = 'Fort';
          _strengthColor = Colors.green;
        } else {
          _strengthLevel = 2;
          _passwordStrength = 'Moyen';
          _strengthColor = Colors.orange;
        }
      }
    });
  }

  Widget _buildPasswordStrengthIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  _buildStrengthBox(1),
                  const SizedBox(width: 4),
                  _buildStrengthBox(2),
                  const SizedBox(width: 4),
                  _buildStrengthBox(3),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _passwordStrength,
              style: TextStyle(
                color: _strengthColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (_strengthLevel > 0)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _getPasswordHint(),
              style: const TextStyle(
                color: AppColors.colorTint500,
                fontSize: 11,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStrengthBox(int level) {
    Color boxColor = _strengthLevel >= level ? _getColorForLevel(level) : Colors.grey.shade300;
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Color _getColorForLevel(int level) {
    switch (level) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getPasswordHint() {
    if (_strengthLevel == 1) {
      return 'Ajoutez au moins 8 caractères';
    } else if (_strengthLevel == 2) {
      return 'Ajoutez des majuscules, des chiffres et des caractères spéciaux';
    } else {
      return 'Excellent mot de passe !';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom complet',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.colorTint500,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
              ),
              _buildPasswordStrengthIndicator(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Simulation d'inscription réussie
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Inscription réussie')),
                    );
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                child: const Text('S\'inscrire'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('Déjà un compte ? Connectez-vous'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      _checkPasswordStrength(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(() {
      _checkPasswordStrength(_passwordController.text);
    });
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
