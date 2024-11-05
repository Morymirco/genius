import 'package:coursenligne/config/theme/theme.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = '/checkout';
  final double totalAmount;

  const CheckoutScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = '';

  void _handlePayment() {
    switch (_selectedPaymentMethod) {
      case 'orange':
        Navigator.pushNamed(
          context,
          '/orange-money',
          arguments: widget.totalAmount,
        );
        break;
      case 'mtn':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('MTN Mobile Money bientôt disponible'),
            backgroundColor: Colors.orange,
          ),
        );
        break;
      case 'moov':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Moov Money bientôt disponible'),
            backgroundColor: Colors.orange,
          ),
        );
        break;
      case 'card':
        Navigator.pushNamed(
          context,
          '/card-info',
          arguments: widget.totalAmount,
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner un mode de paiement'),
            backgroundColor: Colors.red,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paiement',
          style: TextStyle(color: Color(0xFF6A3085)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF6A3085)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(),
            const SizedBox(height: 24),
            _buildPaymentMethods(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _selectedPaymentMethod.isEmpty ? null : _handlePayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A3085),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Continuer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF43BCCD).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.shopping_cart_outlined, color: Color(0xFF43BCCD)),
              SizedBox(width: 8),
              Text(
                'Résumé de la commande',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A3085),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildOrderItem(
            'Flutter Avancé',
            '100 milles GNF',
            'Mory koulibaly',
            'assets/images/marketting.jpg',
          ),
          const Divider(height: 24),
          _buildOrderItem(
            'React Native Master',
            '500 milles GNF',
            'Thierno Suleymane',
            'assets/images/ui-ux-design.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String title, String price, String instructor, String image) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6A3085),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                instructor,
                style: TextStyle(
                  color: const Color(0xFF6A3085).withOpacity(0.7),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: const TextStyle(
            color: Color(0xFF43BCCD),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.payment, color: Color(0xFF43BCCD)),
            SizedBox(width: 8),
            Text(
              'Mode de paiement',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A3085),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildPaymentOption(
          'orange',
          'Orange Money',
          'assets/images/orange-money.png',
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          'mtn',
          'MTN Mobile Money',
          'assets/images/mtn-momo.png',
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          'moov',
          'Moov Money',
          'assets/images/moov-money.png',
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          'card',
          'Carte bancaire',
          'assets/images/visa1.png',
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String value, String title, String imagePath) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _selectedPaymentMethod == value
                ? const Color(0xFF6A3085)
                : AppColors.colorTint300,
            width: _selectedPaymentMethod == value ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.colorTint700,
              ),
            ),
            const Spacer(),
            Radio(
              value: value,
              groupValue: _selectedPaymentMethod,
              onChanged: (String? value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
              activeColor: const Color(0xFF43BCCD),
            ),
          ],
        ),
      ),
    );
  }
} 