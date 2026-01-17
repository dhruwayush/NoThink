import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/core/theme/app_theme.dart';
import 'src/presentation/screens/home_screen.dart';
import 'src/data/services/supabase_service.dart';
import 'src/data/repositories/hive_decision_repository.dart';
import 'src/data/repositories/hive_context_memory_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  final decisionBox = await Hive.openBox('decisions');
  final memoryBox = await Hive.openBox('context_memories');

  // Initialize Supabase
  await SupabaseService().initialize();

  // Sync Data on Startup (Pull from Cloud)
  final decisionRepo = HiveDecisionRepository(decisionBox);
  final memoryRepo = HiveContextMemoryRepository(memoryBox);
  
  // Fire and forget, or await? Awaiting ensures data is there.
  await Future.wait([
    decisionRepo.syncWithRemote(),
    memoryRepo.syncWithRemote(),
  ]);
  
  runApp(const ProviderScope(child: NoThinkApp()));
}

class NoThinkApp extends StatelessWidget {
  const NoThinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoThink',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
