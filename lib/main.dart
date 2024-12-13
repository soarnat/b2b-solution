// lib/main.dart

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

// Core Layer
import 'core/constants/route_constants.dart';
import 'core/network/api_client.dart';
import 'core/storage/secure_storage.dart';
import 'core/themes/app_theme.dart';

// Auth Feature
import 'features/auth/data/datasources/auth_api.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/check_auth.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/widgets/auth_check.dart';

// Features Layer
import 'features/dashboard/presentation/screens/dashboard_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize localization
    await initializeDateFormatting('th');

    // Core Services Setup
    final apiClient = ApiClient();
    final secureStorage = SecureStorage();

    // Auth Feature Setup
    //final authApi = AuthApi(apiClient);
    final authApi = AuthApi();
    final authRepository = AuthRepositoryImpl(
      authApi: authApi,
      secureStorage: secureStorage,
    );

    // Auth UseCases Setup
    final authUseCases = _initializeAuthUseCases(authRepository);

    runApp(MyApp(authUseCases: authUseCases));
  } catch (e, stackTrace) {
    debugPrint('Error initializing app: $e');
    debugPrint('Stack trace: $stackTrace');

    runApp(const ErrorApp()); // แสดง error screen กรณีเกิดปัญหา
  }
}

class AuthUseCases {
  final Login login;
  final Logout logout;
  final GetCurrentUser getCurrentUser;
  final CheckAuth checkAuth;

  const AuthUseCases({
    required this.login,
    required this.logout,
    required this.getCurrentUser,
    required this.checkAuth,
  });
}

AuthUseCases _initializeAuthUseCases(AuthRepositoryImpl authRepository) {
  return AuthUseCases(
    login: Login(authRepository),
    logout: Logout(authRepository),
    getCurrentUser: GetCurrentUser(authRepository),
    checkAuth: CheckAuth(authRepository),
  );
}

class MyApp extends StatelessWidget {
  final AuthUseCases authUseCases;

  const MyApp({
    super.key,
    required this.authUseCases,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            login: authUseCases.login,
            logout: authUseCases.logout,
            getCurrentUser: authUseCases.getCurrentUser,
            checkAuth: authUseCases.checkAuth,
          )..checkAuthStatus(),
        ),
      ],
      child: MaterialApp(
        title: 'B2B Solution',
        debugShowCheckedModeBanner: false,

        // Localization Setup
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('th', ''),
          Locale('en', ''),
        ],
        locale: const Locale('th', ''),

        // Theme Setup
        theme: AppTheme.light,

        // Routes Setup
        initialRoute: RouteConstants.home,
        routes: _buildAppRoutes(),

        // Global Error Handler & UI Scale Protection
        builder: (context, child) {
          // Prevent system font scaling
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }

  Map<String, WidgetBuilder> _buildAppRoutes() {
    return {
      RouteConstants.home: (context) => const AuthStatusWidget(
            authenticatedChild: DashboardScreen(),
            unauthenticatedChild: LoginScreen(),
          ),
      // Add more routes as needed
      // RouteConstants.products: (context) => const AuthStatusWidget(
      //       authenticatedChild: ProductsScreen(),
      //       unauthenticatedChild: LoginScreen(),
      //     ),
    };
  }
}

// Error Screen for critical app failures
class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'เกิดข้อผิดพลาดในการเริ่มต้นแอปพลิเคชัน',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Restart app or retry initialization
                },
                child: const Text('ลองใหม่'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
