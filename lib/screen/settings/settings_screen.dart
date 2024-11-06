import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  String _selectedLanguage = 'Français';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Paramètres',
          style: TextStyle(color: Color(0xFF6A3085)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF6A3085)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Notifications',
              [
                _buildSwitchTile(
                  'Notifications push',
                  'Recevoir des notifications sur votre appareil',
                  _notificationsEnabled,
                  (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Notifications par email',
                  'Recevoir des notifications par email',
                  _emailNotifications,
                  (value) {
                    setState(() {
                      _emailNotifications = value;
                    });
                  },
                ),
              ],
            ),
            _buildSection(
              'Apparence',
              [
                _buildLanguageSelector(),
              ],
            ),
            _buildSection(
              'Sécurité',
              [
                _buildActionTile(
                  'Changer le mot de passe',
                  'Modifier votre mot de passe actuel',
                  Icons.lock_outline,
                  () {
                    // Navigation vers la page de changement de mot de passe
                  },
                ),
                _buildActionTile(
                  'Confidentialité',
                  'Gérer vos paramètres de confidentialité',
                  Icons.security,
                  () {
                    // Navigation vers les paramètres de confidentialité
                  },
                ),
              ],
            ),
            _buildSection(
              'À propos',
              [
                _buildInfoTile(
                  'Version',
                  '1.0.0',
                  Icons.info_outline,
                ),
                _buildActionTile(
                  'Conditions d\'utilisation',
                  'Lire nos conditions d\'utilisation',
                  Icons.description_outlined,
                  () {
                    // Afficher les conditions d'utilisation
                  },
                ),
                _buildActionTile(
                  'Politique de confidentialité',
                  'Lire notre politique de confidentialité',
                  Icons.privacy_tip_outlined,
                  () {
                    // Afficher la politique de confidentialité
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6A3085),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(children: children),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF43BCCD),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return ListTile(
      title: const Text('Langue'),
      subtitle: Text(
        'Choisir la langue de l\'application',
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: DropdownButton<String>(
        value: _selectedLanguage,
        items: ['Français', 'English']
            .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedLanguage = newValue;
            });
          }
        },
        underline: Container(),
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF43BCCD)),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF43BCCD)),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
    );
  }
} 