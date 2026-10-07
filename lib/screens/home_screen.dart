import 'package:flutter/material.dart';

import '../auth/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.auth});

  final AuthController auth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = auth.user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            tooltip: 'Log out',
            onPressed: auth.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 52,
              foregroundImage: user.photoUrl != null
                  ? NetworkImage(user.photoUrl!)
                  : null,
              child: Text(
                user.name.characters.first.toUpperCase(),
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          if (user.username != null)
            Text(
              '@${user.username}',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.badge_outlined),
                  title: const Text('Telegram ID'),
                  subtitle: Text(user.id),
                ),
                if (user.phoneNumber != null)
                  ListTile(
                    leading: const Icon(Icons.phone_outlined),
                    title: const Text('Phone'),
                    subtitle: Text('+${user.phoneNumber}'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
