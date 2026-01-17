import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../providers/settings_provider.dart';
import '../providers/decision_provider.dart';
import '../providers/memory_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Control Settings", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Section
            Text("AI & INTELLIGENCE", style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 1.5, color: AppTheme.textSlate400, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                   SwitchListTile(
                     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                     title: const Text("Processing Mode", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                     subtitle: Text("Enable cloud processing output.", style: TextStyle(color: AppTheme.textSlate400, fontSize: 12)),
                     value: settings.aiProcessingMode, 
                     onChanged: (v) => notifier.toggleAiMode(v),
                     activeColor: AppTheme.primary,
                   ),
                   const Divider(height: 1, color: Colors.white10),
                   Padding(
                     padding: const EdgeInsets.all(20),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             const Text("Entity Sensitivity", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                             Text(settings.entitySensitivity.toInt().toString(), style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 14)),
                           ],
                         ),
                         Slider(
                           value: settings.entitySensitivity,
                           min: 0,
                           max: 100,
                           activeColor: AppTheme.primary,
                           inactiveColor: Colors.white10,
                           onChanged: (v) => notifier.setSensitivity(v),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("LOCAL ONLY", style: TextStyle(color: AppTheme.textSlate400, fontSize: 10, fontWeight: FontWeight.bold)),
                             Text("DEEP SCAN", style: TextStyle(color: AppTheme.textSlate400, fontSize: 10, fontWeight: FontWeight.bold)),
                           ],
                         ),
                       ],
                     ),
                   )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text("Local mode keeps data strictly on-device. AI mode sends anonymized vectors to the cloud.", style: TextStyle(color: AppTheme.textSlate400, fontSize: 12)),
            ),

            const SizedBox(height: 32),

            // Data Section
            Text("DATA SOVEREIGNTY", style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 1.5, color: AppTheme.textSlate400, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
             Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.green.withOpacity(0.1), child: const Icon(Icons.cloud_sync, color: Colors.green, size: 20)),
                    title: const Text("Supabase Sync", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                          child: const Row(
                            children: [
                              Icon(Icons.circle, size: 8, color: Colors.green),
                              SizedBox(width: 4),
                              Text("Active", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right, color: AppTheme.textSlate400),
                      ],
                    ),
                  ),
                   const Divider(height: 1, color: Colors.white10),
                   ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.1), child: const Icon(Icons.download, color: Colors.white70, size: 20)),
                    title: const Text("Export to JSON", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    trailing: const Icon(Icons.chevron_right, color: AppTheme.textSlate400),
                    onTap: () async {
                      final decisions = await ref.read(decisionsProvider.future);
                      final memories = await ref.read(memoriesProvider.future);
                      final dump = {
                        'decisions': decisions.map((d) => d.toJson()).toList(),
                        'memories': memories.map((m) => m.toJson()).toList(),
                      };
                      print(jsonEncode(dump)); // Simple export for MVP
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data dumped to console (MVP)")));
                      }
                    },
                  ),
                   const Divider(height: 1, color: Colors.white10),
                   ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.red.withOpacity(0.1), child: const Icon(Icons.delete_forever, color: Colors.redAccent, size: 20)),
                    title: const Text("Wipe All Memories", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    trailing: const Icon(Icons.chevron_right, color: AppTheme.textSlate400),
                    onTap: () {
                       showDialog(context: context, builder: (c) => AlertDialog(
                         title: const Text("Wipe Everything?"),
                         content: const Text("This cannot be undone. All your decisions and memories will be deleted from this device."),
                         actions: [
                           TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancel")),
                           TextButton(onPressed: () async {
                              await ref.read(decisionsProvider.notifier).clearAll();
                              await ref.read(memoriesProvider.notifier).clearAll();
                              if (c.mounted) Navigator.pop(c);
                              if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All data wiped.")));
                           }, child: const Text("Wipe", style: TextStyle(color: Colors.red))),
                         ],
                       ));
                    },
                  ),
                ],
              ),
             ),

            const SizedBox(height: 32),
             // App Info
             Center(
               child: Column(
                 children: [
                   Container(
                     padding: const EdgeInsets.all(12),
                     decoration: BoxDecoration(
                       gradient: const LinearGradient(colors: [Color(0xFF2A3642), Color(0xFF1B242C)]),
                       borderRadius: BorderRadius.circular(12),
                       border: Border.all(color: Colors.white10),
                     ),
                     child: const Icon(Icons.psychology, color: Colors.white54, size: 24),
                   ),
                   const SizedBox(height: 12),
                   Text("NoThink v2.4.1 (Build 890)", style: TextStyle(color: AppTheme.textSlate400, fontWeight: FontWeight.bold, fontSize: 12)),
                   Text("Cognitive Offloading Engine", style: TextStyle(color: AppTheme.textSlate400, fontSize: 10)),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }
}
