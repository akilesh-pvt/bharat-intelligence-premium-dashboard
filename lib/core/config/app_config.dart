import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // Supabase Configuration
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  
  // Google OAuth Configuration
  static String get googleClientId => dotenv.env['GOOGLE_CLIENT_ID'] ?? '';
  
  // App Configuration
  static String get appName => dotenv.env['APP_NAME'] ?? 'Bharat Intelligence';
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';
  
  // API Configuration
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static int get apiTimeout => int.parse(dotenv.env['API_TIMEOUT'] ?? '30000');
  
  // Feature Flags
  static bool get enableAnalytics => dotenv.env['ENABLE_ANALYTICS'] == 'true';
  static bool get enablePushNotifications => dotenv.env['ENABLE_PUSH_NOTIFICATIONS'] == 'true';
  static bool get debugMode => dotenv.env['DEBUG_MODE'] == 'true';
  
  // Validation
  static bool get isConfigured {
    return supabaseUrl.isNotEmpty && 
           supabaseAnonKey.isNotEmpty && 
           googleClientId.isNotEmpty;
  }

  // Initialize configuration
  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
    
    if (!isConfigured) {
      throw Exception('App configuration is incomplete. Check your .env file.');
    }
  }
}