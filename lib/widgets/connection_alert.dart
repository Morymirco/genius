import 'package:flutter/material.dart';

class ConnectionAlert extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ConnectionAlert({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);

  static void show(BuildContext context, String message, {VoidCallback? onRetry}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConnectionAlert(
        message: message,
        onRetry: onRetry,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: const [
          Icon(Icons.signal_wifi_off, color: Colors.red),
          SizedBox(width: 8),
          Text('Pas de connexion Internet'),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fermer'),
        ),
        if (onRetry != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onRetry!();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF43BCCD),
            ),
            child: const Text('Réessayer'),
          ),
      ],
    );
  }
} 