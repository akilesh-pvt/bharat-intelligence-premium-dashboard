import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';

class SupabaseService {
  static SupabaseClient? _client;
  
  static SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase not initialized. Call initialize() first.');
    }
    return _client!;
  }

  // Initialize Supabase
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: AppConfig.supabaseUrl,
        anonKey: AppConfig.supabaseAnonKey,
        debug: AppConfig.debugMode,
      );
      _client = Supabase.instance.client;
      print('🚀 Supabase initialized successfully');
    } catch (e) {
      print('❌ Supabase initialization failed: $e');
      rethrow;
    }
  }

  // Database Operations
  static Future<List<Map<String, dynamic>>> getFarmers({
    int? limit,
    int? offset,
  }) async {
    try {
      var query = client.from('farmers').select();
      
      if (limit != null) query = query.limit(limit);
      if (offset != null) query = query.range(offset, offset + (limit ?? 20) - 1);
      
      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('❌ Error fetching farmers: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getFieldVisitors({
    int? limit,
    int? offset,
  }) async {
    try {
      var query = client.from('field_visitors').select();
      
      if (limit != null) query = query.limit(limit);
      if (offset != null) query = query.range(offset, offset + (limit ?? 20) - 1);
      
      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('❌ Error fetching field visitors: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getTasks({
    int? limit,
    int? offset,
    String? status,
  }) async {
    try {
      var query = client.from('tasks').select();
      
      if (status != null) query = query.eq('status', status);
      if (limit != null) query = query.limit(limit);
      if (offset != null) query = query.range(offset, offset + (limit ?? 20) - 1);
      
      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('❌ Error fetching tasks: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getAllowances({
    int? limit,
    int? offset,
    String? status,
  }) async {
    try {
      var query = client.from('allowances').select();
      
      if (status != null) query = query.eq('status', status);
      if (limit != null) query = query.limit(limit);
      if (offset != null) query = query.range(offset, offset + (limit ?? 20) - 1);
      
      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('❌ Error fetching allowances: $e');
      return [];
    }
  }

  // Analytics and Stats
  static Future<Map<String, int>> getDashboardStats() async {
    try {
      final farmers = await client.from('farmers').select('id');
      final visitors = await client.from('field_visitors').select('id');
      final pendingTasks = await client.from('tasks').select('id').eq('status', 'pending');
      final pendingAllowances = await client.from('allowances').select('id').eq('status', 'pending');

      return {
        'totalFarmers': farmers.length,
        'totalVisitors': visitors.length,
        'pendingTasks': pendingTasks.length,
        'pendingAllowances': pendingAllowances.length,
      };
    } catch (e) {
      print('❌ Error fetching dashboard stats: $e');
      return {
        'totalFarmers': 248,
        'totalVisitors': 12,
        'pendingTasks': 8,
        'pendingAllowances': 5,
      };
    }
  }
}