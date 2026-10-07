import 'package:flutter/material.dart';

import 'auth/auth_controller.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(auth: AuthController()..init()));
}

class App extends StatelessWidget {
  const App({super.key, required this.auth});

  final AuthController auth;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF2AABEE)),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF2AABEE),
        brightness: Brightness.dark,
      ),
      home: ListenableBuilder(
        listenable: auth,
        builder: (context, _) {
          if (!auth.isReady) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return auth.user == null
              ? LoginScreen(auth: auth)
              : HomeScreen(auth: auth);
        },
      ),
    );
  }
}
