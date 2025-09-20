class AppConstants {
  // App Info
  static const String appName = 'Bharat Intelligence';
  static const String appTagline = 'Smart Field Operations Management';
  static const String version = '1.0.0';

  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 600);

  // API Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration shortTimeout = Duration(seconds: 10);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Image Constraints
  static const double maxImageSize = 5.0; // MB
  static const int imageQuality = 85;

  // Cache Settings
  static const Duration cacheExpiry = Duration(hours: 24);
  static const int maxCacheSize = 100; // MB

  // Feature Flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePerformanceMonitoring = true;

  // Routes
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String farmersRoute = '/farmers';
  static const String visitorsRoute = '/visitors';
  static const String tasksRoute = '/tasks';
  static const String allowancesRoute = '/allowances';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
}