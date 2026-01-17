import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  /// Initialize Supabase
  Future<void> initialize() async {
    // Load env vars
    await dotenv.load(fileName: ".env");

    final url = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (url == null || anonKey == null || url.contains('YOUR_SUPABASE_URL')) {
      // Fallback/Warning if credentials are missing.
      // We don't crash, we just don't init Supabase properly or init with dummy data to avoid runtime crashes
      // but functionality will effectively be "offline".
      print("WARNING: Supabase credentials missing in .env. Cloud sync will be disabled.");
      return;
    }

    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  SupabaseClient? get client {
    try {
      return Supabase.instance.client;
    } catch (e) {
      return null;
    }
  }

  bool get isInitialized => client != null;
}
