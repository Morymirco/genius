import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/screen/auth/login_screen.dart';
import 'package:coursenligne/screen/auth/widgets/auth_field.dart';
import 'package:coursenligne/screen/auth/widgets/logo_widget.dart';
import 'package:coursenligne/screen/auth/widgets/social_button.dart';
import 'package:coursenligne/screen/nav/nav.dart';
import 'package:coursenligne/services/auth_service.dart';
import 'package:coursenligne/services/firestore_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  final _firestoreService = FirestoreService();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  String _passwordStrength = '';
  Color _strengthColor = Colors.grey;
  int _strengthLevel = 0;

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
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      _checkPasswordStrength(_passwordController.text);
    });
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Créer l'utilisateur avec Firebase Auth
        final userCredential = await _authService.signUpWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim(),
        );

        if (userCredential?.user != null) {
          // Créer le profil utilisateur dans Firestore avec des données minimales
          await _firestoreService.createUserProfile(
            userCredential!.user!.uid,
            {
              'name': _nameController.text.trim(),
              'email': _emailController.text.trim(),
              'photoURL': '',
              'role': 'student',
              'createdAt': DateTime.now().toIso8601String(),
              'updatedAt': DateTime.now().toIso8601String(),
            },
          );

          if (mounted) {
            // Attendre un peu avant de naviguer
            await Future.delayed(const Duration(milliseconds: 500));
            
            // Rediriger vers la page principale
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Nav()),
              (route) => false,
            );

            // Afficher le message de succès après la navigation
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Inscription réussie !'),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      } catch (e) {
        print('Erreur détaillée: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur lors de l\'inscription. Veuillez réessayer.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _handleGoogleSignIn() {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    _authService.signInWithGoogle().then((userCredential) async {
      if (userCredential != null && userCredential.user != null) {
        try {
          // Vérifier si l'utilisateur existe déjà dans Firestore
          final userDoc = await _firestoreService.getUserProfile(userCredential.user!.uid);
          
          if (!userDoc.exists) {
            // Si l'utilisateur n'existe pas, créer son profil
            await _firestoreService.createUserProfile(
              userCredential.user!.uid,
              {
                'name': userCredential.user!.displayName ?? '',
                'email': userCredential.user!.email ?? '',
                'photoURL': userCredential.user!.photoURL ?? '',
                'role': 'student',
                'createdAt': DateTime.now().toIso8601String(),
                'updatedAt': DateTime.now().toIso8601String(),
                'enrolledCourses': [],
                'favorites': [],
                'completedCourses': [],
                'cart': [],
              },
            );
            print('Profil utilisateur créé dans Firestore');
          }

          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Nav()),
              (route) => false,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Connexion réussie !'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } catch (e) {
          print('Erreur lors de la création du profil Firestore: $e');
          // En cas d'erreur, déconnecter l'utilisateur
          await _authService.signOut();
          throw e;
        }
      }
    }).catchError((e) {
      print('Erreur de connexion Google: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la connexion avec Google'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }).whenComplete(() {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(() {
      _checkPasswordStrength(_passwordController.text);
    });
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const LogoWidget(),
                  const SizedBox(height: 20),
                  Text(
                    'Inscription',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.colorTint700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Créez votre compte Geniusclass',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.colorTint500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AuthField(
                    controller: _nameController,
                    hintText: 'Nom complet',
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AuthField(
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      if (!value.contains('@')) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AuthField(
                    controller: _passwordController,
                    hintText: 'Mot de passe',
                    icon: Icons.lock_outline,
                    obscureText: !_isPasswordVisible,
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
                  
                  AuthField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirmer le mot de passe',
                    icon: Icons.lock_outline,
                    obscureText: !_isConfirmPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.colorTint500,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez confirmer votre mot de passe';
                      }
                      if (value != _passwordController.text) {
                        return 'Les mots de passe ne correspondent pas';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A3085),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'S\'inscrire',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(child: _buildDivider()),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Ou s\'inscrire avec',
                          style: TextStyle(
                            color: AppColors.colorTint500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(child: _buildDivider()),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SocialButton(
                    iconPath: 'assets/icons/google.svg',
                    label: 'Continuer avec Google',
                    onPressed: _handleGoogleSignIn,
                  ),
                  const SizedBox(height: 16),
                  SocialButton(
                    iconPath: 'assets/icons/apple.svg',
                    label: 'Continuer avec Apple',
                    onPressed: () {
                      // Implémenter l'inscription Apple
                    },
                    isApple: true,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Déjà un compte ? ',
                        style: TextStyle(color: AppColors.colorTint500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(
                            color: AppColors.colorPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColors.colorTint300,
    );
  }
} 