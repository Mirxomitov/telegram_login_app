import 'package:flutter/material.dart';

import '../auth/auth_controller.dart';

const _telegramBlue = Color(0xFF2AABEE);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.auth});

  final AuthController auth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              const CircleAvatar(
                radius: 44,
                backgroundColor: _telegramBlue,
                child: Icon(Icons.send_rounded, size: 44, color: Colors.white),
              ),
              const SizedBox(height: 24),
              Text('Welcome', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Sign in with your Telegram account to continue.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              if (auth.error != null) ...[
                Text(
                  auth.error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
                const SizedBox(height: 16),
              ],
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: _telegramBlue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: _telegramBlue.withValues(
                      alpha: 0.6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: auth.isLoading ? null : auth.login,
                  icon: auth.isLoading
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send_rounded),
                  label: Text(
                    auth.isLoading
                        ? 'Waiting for Telegram…'
                        : 'Log in with Telegram',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: auth.isLoading
                    ? TextButton(
                        onPressed: auth.cancelLogin,
                        child: const Text('Cancel'),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
