import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/config/supabase_config.dart';
import 'core/storage/secure_storage.dart';
import 'core/storage/hive_storage.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/users/data/repositories/user_repository.dart';
import 'features/users/presentation/providers/user_provider.dart';
import 'features/companies/data/repositories/company_repository.dart';
import 'features/companies/presentation/providers/company_provider.dart';
import 'features/contacts/data/repositories/contact_person_repository.dart';
import 'features/contacts/presentation/providers/contact_person_provider.dart';
import 'features/contacts/data/repositories/contact_record_repository.dart';
import 'features/contacts/presentation/providers/contact_record_provider.dart';
import 'features/reminders/data/repositories/reminder_repository.dart';
import 'features/reminders/presentation/providers/reminder_provider.dart';
import 'core/utils/notification_helper.dart';
import 'app.dart';

/// Application entry point
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize Supabase
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
    debug: SupabaseConfig.enableDebug,
  );

  // Initialize Hive for local caching
  await Hive.initFlutter();
  final hiveStorage = HiveStorage();
  await hiveStorage.init();

  // Initialize secure storage
  final secureStorage = SecureStorage();

  // Initialize notifications
  print('🔔 Initializing notifications...');
  final notificationHelper = NotificationHelper();
  await notificationHelper.init();
  print('✅ Notifications initialized');

  print('🔔 Requesting notification permissions...');
  final permissionsGranted = await notificationHelper.requestPermissions();
  print('✅ Notification permissions: ${permissionsGranted ? "GRANTED" : "DENIED"}');

  // Create repositories
  final authRepository = AuthRepository(
    supabase: Supabase.instance.client,
    secureStorage: secureStorage,
  );

  // Create providers
  final authProvider = AuthProvider(authRepository: authRepository);

  // Initialize auth state (check if user is already logged in)
  await authProvider.initializeAuth();

  // Run app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),

        // UserProvider (depends on AuthProvider)
        ChangeNotifierProxyProvider<AuthProvider, UserProvider?>(
          create: (_) => null,
          update: (context, authProvider, previous) {
            // Only create UserProvider if user is authenticated and has organization
            if (authProvider.isAuthenticated &&
                authProvider.currentUser != null) {
              final organizationId = authProvider.currentUser!.organizationId;
              final userRepository = UserRepository(
                supabase: Supabase.instance.client,
                organizationId: organizationId,
              );
              return UserProvider(userRepository: userRepository);
            }
            return null;
          },
        ),

        // CompanyProvider (depends on AuthProvider)
        ChangeNotifierProxyProvider<AuthProvider, CompanyProvider?>(
          create: (_) => null,
          update: (context, authProvider, previous) {
            // Only create CompanyProvider if user is authenticated and has organization
            if (authProvider.isAuthenticated &&
                authProvider.currentUser != null) {
              final organizationId = authProvider.currentUser!.organizationId;
              final companyRepository = CompanyRepository(
                supabase: Supabase.instance.client,
                organizationId: organizationId,
              );
              return CompanyProvider(companyRepository: companyRepository);
            }
            return null;
          },
        ),

        // ContactPersonProvider (does not depend on organization_id)
        ChangeNotifierProvider(
          create: (_) {
            final contactPersonRepository = ContactPersonRepository(
              supabase: Supabase.instance.client,
            );
            return ContactPersonProvider(repository: contactPersonRepository);
          },
        ),

        // ContactRecordProvider (does not depend on organization_id)
        ChangeNotifierProvider(
          create: (_) {
            final contactRecordRepository = ContactRecordRepository(
              supabase: Supabase.instance.client,
            );
            return ContactRecordProvider(repository: contactRecordRepository);
          },
        ),

        // ReminderProvider (does not depend on organization_id)
        ChangeNotifierProvider(
          create: (_) {
            final reminderRepository = ReminderRepository(
              supabase: Supabase.instance.client,
            );
            return ReminderProvider(
              repository: reminderRepository,
              notificationHelper: notificationHelper,
            );
          },
        ),
      ],
      child: const App(),
    ),
  );
}
