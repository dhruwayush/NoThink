import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/decision.dart';
import '../../domain/models/context_memory.dart';
import '../providers/decision_provider.dart';
import '../providers/memory_provider.dart';

class RecallDetailScreen extends ConsumerWidget {
  final dynamic item; // Decision or ContextMemory
  
  const RecallDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDecision = item is Decision;
    final String title = isDecision ? (item as Decision).title : (item as ContextMemory).entityName;
    final String content = isDecision ? (item as Decision).finalChoice : (item as ContextMemory).memory;
    final icon = isDecision ? Icons.check_circle : Icons.lightbulb;
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Searching: "$title"', style: const TextStyle(color: Colors.white70, fontSize: 14)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Best Match Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white10),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 6, width: double.infinity, decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppTheme.primary, Colors.blueAccent]))),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                               decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                               child: const Text("BEST MATCH", style: TextStyle(color: AppTheme.primary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                             ),
                             const Icon(Icons.verified, color: AppTheme.textSlate400, size: 20),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Text(title, style: const TextStyle(fontSize: 18, color: AppTheme.textSlate400)),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, size: 16, color: AppTheme.textSlate400),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          content,
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppTheme.primary.withOpacity(0.2),
                              child: Icon(icon, color: AppTheme.primary),
                            ),
                            const SizedBox(width: 12),
                            const Text("Last updated recently", style: TextStyle(color: AppTheme.textSlate400, fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            // Actions
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () async {
                           if (isDecision) {
                             final updated = (item as Decision).copyWith(lastUsedAt: DateTime.now());
                             await ref.read(decisionsProvider.notifier).updateDecision(updated);
                           } else {
                             final updated = (item as ContextMemory).copyWith(lastTriggered: DateTime.now());
                             await ref.read(memoriesProvider.notifier).updateMemory(updated);
                           }
                           if (context.mounted) {
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Marked as used")));
                             Navigator.of(context).pop();
                           }
                        },
                        icon: const Icon(Icons.check_circle, color: Colors.white),
                        label: const Text("Mark as Used", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Not what I needed", style: TextStyle(color: AppTheme.textSlate400)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
