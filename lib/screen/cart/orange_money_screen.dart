import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OrangeMoneyScreen extends StatefulWidget {
  static String routeName = '/orange-money';
  final double amount;

  const OrangeMoneyScreen({Key? key, required this.amount}) : super(key: key);

  @override
  State<OrangeMoneyScreen> createState() => _OrangeMoneyScreenState();
}

class _OrangeMoneyScreenState extends State<OrangeMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isLoading = false;

  final _phoneFormatter = MaskTextInputFormatter(
    mask: '### ## ## ##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<void> _handlePayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simuler un délai de traitement
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Afficher une boîte de dialogue de confirmation
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/orange-money.png',
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 10),
                const Text('Confirmation'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Détails de la transaction :'),
                const SizedBox(height: 10),
                _buildDetailRow('Montant', '${widget.amount.toStringAsFixed(0)} GNF'),
                _buildDetailRow('Numéro', _phoneController.text),
                const SizedBox(height: 16),
                const Text(
                  'Paiement effectué avec succès !',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Retourner à la page d'accueil
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Terminer'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors du paiement'),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paiement Orange Money',
          style: TextStyle(color: Color(0xFF6A3085)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF6A3085)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/orange-money.png',
                  height: 100,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.orange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Montant à payer : ${widget.amount.toStringAsFixed(0)} GNF',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'Numéro Orange Money',
                controller: _phoneController,
                formatter: _phoneFormatter,
                keyboardType: TextInputType.number,
                prefixText: '+224 ',
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer votre numéro';
                  }
                  if (value!.length < 11) {
                    return 'Numéro invalide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'Code de paiement',
                controller: _codeController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer le code';
                  }
                  if (value!.length < 4) {
                    return 'Code invalide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handlePayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
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
                          'Confirmer le paiement',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    TextInputFormatter? formatter,
    TextInputType? keyboardType,
    String? prefixText,
    bool obscureText = false,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A3085),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          inputFormatters: formatter != null ? [formatter] : null,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLength: maxLength,
          decoration: InputDecoration(
            prefixText: prefixText,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            counterText: '',
          ),
          validator: validator,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }
} 