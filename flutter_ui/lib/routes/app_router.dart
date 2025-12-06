import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/password_reset_page.dart';

/// Application router configuration
///
/// Defines all routes and navigation logic with auth guards.
class AppRouter {
  final AuthProvider authProvider;

  AppRouter({required this.authProvider});

  /// Create GoRouter instance
  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: authProvider,
    redirect: _handleRedirect,
    routes: [
      // Auth routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/password-reset',
        name: 'password-reset',
        builder: (context, state) => const PasswordResetPage(),
      ),

      // Protected routes - placeholder for now
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const _PlaceholderHomePage(),
      ),

      // TODO: Add more routes in future phases:
      // - /companies (CompaniesListPage)
      // - /companies/:id (CompanyDetailPage)
      // - /companies/create (CompanyCreatePage)
      // - /companies/:id/edit (CompanyEditPage)
      // - /users (UsersListPage) - admin only
      // - /users/create (UserCreatePage) - admin only
      // - /notifications (NotificationsPage)
      // - /profile (ProfilePage)
    ],
    errorBuilder: (context, state) => const _ErrorPage(),
  );

  /// Handle redirects based on auth state
  ///
  /// - If not authenticated → redirect to /login
  /// - If authenticated and on /login → redirect to /
  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = authProvider.isAuthenticated;
    final isLoggingIn = state.matchedLocation == '/login';
    final isPasswordReset = state.matchedLocation == '/password-reset';

    // Allow access to login and password reset pages when not authenticated
    if (!isAuthenticated) {
      if (isLoggingIn || isPasswordReset) {
        return null; // Allow access
      }
      return '/login'; // Redirect to login
    }

    // If authenticated and trying to access login page, redirect to home
    if (isLoggingIn || isPasswordReset) {
      return '/';
    }

    // No redirect needed
    return null;
  }
}

/// Placeholder home page
///
/// TODO: Replace with actual CompaniesListPage in Phase 4
class _PlaceholderHomePage extends StatelessWidget {
  const _PlaceholderHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Комплексное обеспечение'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO: Get AuthProvider and call logout
              // For now, just show a message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Выход из системы (TODO: implement)'),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction,
              size: 64,
              color: Color(0xFF8F9098),
            ),
            const SizedBox(height: 16),
            const Text(
              'Добро пожаловать!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sora',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Компании, пользователи и другие экраны\nбудут добавлены в следующих фазах.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8F9098),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Error page for 404 and other routing errors
class _ErrorPage extends StatelessWidget {
  const _ErrorPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFFF53178),
            ),
            const SizedBox(height: 16),
            const Text(
              'Страница не найдена',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sora',
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navigate to home
                context.go('/');
              },
              child: const Text(
                'Вернуться на главную',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF006FFD),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
