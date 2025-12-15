import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/password_reset_page.dart';
import '../features/users/presentation/pages/users_list_page.dart';
import '../features/users/presentation/pages/user_form_page.dart';
import '../features/companies/presentation/pages/companies_list_page.dart';
import '../features/companies/presentation/pages/company_form_page.dart';
import '../features/companies/presentation/pages/company_detail_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../features/debug/notification_debug_page.dart';
import '../core/widgets/main_scaffold.dart';

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

      // Home route - Companies list
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainScaffold(
          currentIndex: 0,
          child: CompaniesListPage(),
        ),
      ),

      // Companies list (same as home, but accessible via /companies)
      GoRoute(
        path: '/companies',
        name: 'companies',
        builder: (context, state) => const MainScaffold(
          currentIndex: 0,
          child: CompaniesListPage(),
        ),
      ),

      // Settings page
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const MainScaffold(
          currentIndex: 1,
          child: SettingsPage(),
        ),
      ),

      // User management routes (admin only)
      GoRoute(
        path: '/users',
        name: 'users',
        builder: (context, state) => const UsersListPage(),
      ),
      GoRoute(
        path: '/users/create',
        name: 'user-create',
        builder: (context, state) => const UserFormPage(),
      ),
      GoRoute(
        path: '/users/:id/edit',
        name: 'user-edit',
        builder: (context, state) {
          final userId = state.pathParameters['id'];
          return UserFormPage(userId: userId);
        },
      ),

      // Company routes
      GoRoute(
        path: '/companies/create',
        name: 'company-create',
        builder: (context, state) => const CompanyFormPage(),
      ),
      GoRoute(
        path: '/companies/:id',
        name: 'company-detail',
        builder: (context, state) {
          final companyId = state.pathParameters['id']!;
          return CompanyDetailPage(companyId: companyId);
        },
      ),
      GoRoute(
        path: '/companies/:id/edit',
        name: 'company-edit',
        builder: (context, state) {
          final companyId = state.pathParameters['id'];
          return CompanyFormPage(companyId: companyId);
        },
      ),

      // DEBUG: Uncomment to enable notification diagnostics page
      // GoRoute(
      //   path: '/debug/notifications',
      //   name: 'debug-notifications',
      //   builder: (context, state) => const NotificationDebugPage(),
      // ),

      // TODO: Add more routes in future phases:
      // - /notifications (NotificationsPage)
      // - /profile (ProfilePage)
    ],
    errorBuilder: (context, state) => const _ErrorPage(),
  );

  /// Handle redirects based on auth state
  ///
  /// - If not authenticated → redirect to /login
  /// - If authenticated and on /login → redirect to /
  /// - If not admin trying to access /users → redirect to /
  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = authProvider.isAuthenticated;
    final isAdmin = authProvider.isAdmin;
    final isLoggingIn = state.matchedLocation == '/login';
    final isPasswordReset = state.matchedLocation == '/password-reset';
    final isUsersRoute = state.matchedLocation.startsWith('/users');

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

    // Admin guard: Only admins can access /users routes
    if (isUsersRoute && !isAdmin) {
      return '/';
    }

    // No redirect needed
    return null;
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
