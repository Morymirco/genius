import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/screen/nav/nav.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  static String routeName = '/otp';
  final String phoneNumber;
  final String verificationId;

  const OTPScreen({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  int _resendTimer = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
        _startResendTimer();
      } else if (mounted) {
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.length != 6) {
      setState(() {
        _errorMessage = 'Veuillez entrer un code OTP valide';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // String otpCode = _otpController.text;
      
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Nav()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Code OTP invalide';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOTP() async {
    if (!_canResend) return;

    setState(() {
      _canResend = false;
      _resendTimer = 60;
      _errorMessage = '';
    });

    try {
      _startResendTimer();
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Erreur lors de l\'envoi du code';
          _canResend = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.colorTint700),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vérification OTP',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.colorTint700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Un code a été envoyé au ${widget.phoneNumber}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.colorTint500,
                ),
              ),
              const SizedBox(height: 32),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  activeFillColor: Colors.white,
                  activeColor: AppColors.colorPrimary,
                  selectedColor: AppColors.colorPrimary,
                  inactiveColor: AppColors.colorTint300,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: false,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (mounted) {
                    setState(() {
                      _errorMessage = '';
                    });
                  }
                },
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.colorPrimary,
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
                          'Vérifier',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Vous n\'avez pas reçu de code ? ',
                    style: TextStyle(color: AppColors.colorTint500),
                  ),
                  GestureDetector(
                    onTap: _canResend ? _resendOTP : null,
                    child: Text(
                      _canResend
                          ? 'Renvoyer'
                          : 'Renvoyer dans $_resendTimer s',
                      style: TextStyle(
                        color: _canResend
                            ? AppColors.colorPrimary
                            : AppColors.colorTint500,
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
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
} 