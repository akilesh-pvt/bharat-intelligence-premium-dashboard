import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/admin.dart';
import '../config/app_config.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  static final SupabaseClient _supabase = Supabase.instance.client;
  Admin? _currentAdmin;

  // Getters
  bool get isAuthenticated => _currentAdmin != null;
  Admin? get currentAdmin => _currentAdmin;

  // Modern Google Sign-In Implementation
  Future<Admin?> signInWithGoogle() async {
    try {
      // Try silent sign-in first (recommended by Google)
      GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
      
      // If silent sign-in fails, use interactive sign-in
      googleUser ??= await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw Exception('Google sign-in was cancelled');
      }

      debugPrint('🎉 Google sign-in successful: ${googleUser.email}');

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      
      debugPrint('Access Token: ${googleAuth.accessToken != null ? "✅ Available" : "❌ Missing"}');
      debugPrint('ID Token: ${googleAuth.idToken != null ? "✅ Available" : "❌ Missing"}');

      // Handle missing ID token gracefully (common on web)
      if (googleAuth.idToken == null) {
        debugPrint('⚠️ ID Token missing - using email validation only');
      }

      // Create admin from Google user data
      final admin = Admin(
        id: googleUser.id,
        name: googleUser.displayName ?? 'Unknown User',
        email: googleUser.email,
        photoUrl: googleUser.photoUrl,
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
        lastLogin: DateTime.now(),
      );

      // Store current admin
      _currentAdmin = admin;

      // Store admin info in Supabase
      await _storeAdminInfo(admin);

      return admin;
    } catch (e) {
      debugPrint('❌ Google sign-in error: $e');
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  // Store admin information in Supabase
  Future<void> _storeAdminInfo(Admin admin) async {
    try {
      await _supabase.from('admins').upsert({
        'id': admin.id,
        'name': admin.name,
        'email': admin.email,
        'photo_url': admin.photoUrl,
        'is_active': admin.isActive,
        'role': admin.role,
        'updated_at': DateTime.now().toIso8601String(),
      });
      debugPrint('✅ Admin info stored successfully');
    } catch (e) {
      debugPrint('⚠️ Failed to store admin info: $e');
      // Don't throw error here, as sign-in was successful
    }
  }

  // Get current user
  Future<Admin?> getCurrentUser() async {
    try {
      final GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
      
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = 
            await googleUser.authentication;
        
        final admin = Admin(
          id: googleUser.id,
          name: googleUser.displayName ?? 'Unknown User',
          email: googleUser.email,
          photoUrl: googleUser.photoUrl,
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        _currentAdmin = admin;
        return admin;
      }
      
      _currentAdmin = null;
      return null;
    } catch (e) {
      debugPrint('❌ Error getting current user: $e');
      _currentAdmin = null;
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _currentAdmin = null;
      debugPrint('✅ User signed out successfully');
    } catch (e) {
      debugPrint('❌ Error signing out: $e');
      throw Exception('Failed to sign out: $e');
    }
  }

  // Check if user can access required scopes
  Future<bool> canAccessScopes() async {
    try {
      return await _googleSignIn.canAccessScopes(['email', 'profile']);
    } catch (e) {
      debugPrint('❌ Error checking scopes: $e');
      return false;
    }
  }

  // Request additional scopes
  Future<bool> requestScopes(List<String> scopes) async {
    try {
      return await _googleSignIn.requestScopes(scopes);
    } catch (e) {
      debugPrint('❌ Error requesting scopes: $e');
      return false;
    }
  }

  // Initialize authentication service
  Future<void> initialize() async {
    try {
      // Check for existing user session
      await getCurrentUser();
      debugPrint('🚀 AuthService initialized successfully');
    } catch (e) {
      debugPrint('⚠️ AuthService initialization warning: $e');
    }
  }
}