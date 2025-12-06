import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/config/theme.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'routes/app_router.dart';

/// Root application widget
///
/// Sets up theme, providers, and routing.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // Create router with auth provider
        final router = AppRouter(authProvider: authProvider).router;

        return MaterialApp.router(
          title: 'Комплексное обеспечение',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: router,
        );
      },
    );
  }
}
