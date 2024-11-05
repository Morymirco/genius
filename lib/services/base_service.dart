import 'package:coursenligne/services/connectivity_service.dart';
import 'package:coursenligne/widgets/connection_alert.dart';
import 'package:flutter/material.dart';

class BaseService {
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<bool> checkConnection(BuildContext context) async {
    final hasConnection = await _connectivityService.checkInternetConnection();
    if (!hasConnection && context.mounted) {
      ConnectionAlert.show(
        context,
        'Cette action nécessite une connexion Internet. Veuillez vérifier votre connexion et réessayer.',
      );
    }
    return hasConnection;
  }
} 