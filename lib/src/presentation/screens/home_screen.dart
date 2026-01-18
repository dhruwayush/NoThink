import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../providers/ranking_provider.dart';
import '../providers/query_provider.dart';
import '../providers/decision_provider.dart';
import '../providers/memory_provider.dart';
import '../../domain/models/decision.dart';
import '../../domain/models/context_memory.dart';
import 'add_decision_screen.dart';
import 'add_memory_screen.dart';
import 'settings_screen.dart';
import 'recall_detail_screen.dart';
import 'insights_screen.dart';
import 'history_screen.dart';
import '../../domain/models/recall_result.dart';
import '../widgets/glass_container.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(queryProvider);
    final recallResultsAsync = ref.watch(rankingProvider);

    // Determine data for "Recent Recalls"
    final decisions = ref.watch(decisionsProvider).valueOrNull ?? [];
    final memories = ref.watch(memoriesProvider).valueOrNull ?? [];

    // Combine and sort by lastUsedAt (Descending)
    final recentItems = <dynamic>[...decisions, ...memories];
    
    recentItems.sort((a, b) {
      DateTime? da = (a is Decision) ? a.lastUsedAt : (a is ContextMemory) ? a.lastTriggered : null;
      DateTime? db = (b is Decision) ? b.lastUsedAt : (b is ContextMemory) ? b.lastTriggered : null;
      da ??= DateTime(2000); 
      db ??= DateTime(2000);
      return db.compareTo(da);
    });
    final recents = recentItems.take(3).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // 1. Dashboard Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   IconButton(
                     icon: const Icon(Icons.settings, color: Colors.white70),
                     onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const SettingsScreen())),
                   ),
                   IconButton(
                     icon: const Icon(Icons.bar_chart, color: Colors.cyanAccent),
                     onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const InsightsScreen())),
                   ),
                    GlassContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      opacity: 0.05,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.radio_button_checked, color: AppTheme.primary.withOpacity(0.8), size: 16),
                          const SizedBox(width: 8),
                          Text(
                            "NOTHINK",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                   IconButton(
                     icon: const Icon(Icons.history, color: Colors.white70),
                     onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const HistoryScreen())),
                   ),
                ],
              ),

              const SizedBox(height: 32),

              // 2. Search Bar (Always visible)
              Container(
                 decoration: BoxDecoration(
                   color: AppTheme.surfaceDark,
                   borderRadius: BorderRadius.circular(16),
                   border: Border.all(color: AppTheme.primary.withOpacity(0.5), width: 1.5),
                   boxShadow: [
                     BoxShadow(
                       color: AppTheme.primary.withOpacity(0.1),
                       blurRadius: 12,
                       offset: const Offset(0, 4),
                     ),
                   ],
                 ),
                 child: TextField(
                   controller: _searchController,
                   style: const TextStyle(color: Colors.white, fontSize: 16),
                   decoration: InputDecoration(
                     hintText: "Type keywords...",
                     hintStyle: const TextStyle(color: AppTheme.textSlate400),
                     prefixIcon: Icon(Icons.search, color: AppTheme.primary),
                     suffixIcon: query.isNotEmpty 
                        ? IconButton(
                            icon: const Icon(Icons.close, color: Colors.white54),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(queryProvider.notifier).setQuery('');
                            },
                          ) 
                        : null,
                     border: InputBorder.none,
                     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                   ),
                   onChanged: (val) {
                      ref.read(queryProvider.notifier).setQuery(val);
                   },
                 ),
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 24),

              // 3. Content Switcher
              Expanded(
                child: query.isEmpty 
                  ? _buildLandingContent(context, recents)
                  : _buildSearchResults(context, recallResultsAsync),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLandingContent(BuildContext context, List<dynamic> recents) {
    return Column(
      children: [
         const  Spacer(flex: 1),
         Text(
          "What do you want to\nrecall?",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1.2,
          ),
        ).animate().fadeIn().slideY(begin: 0.2, end: 0),
        
        const SizedBox(height: 40),

        // Recent Recalls Chips
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 14, color: AppTheme.textSlate400),
            SizedBox(width: 8),
            Text(
              "RECENT RECALLS",
              style: TextStyle(
                color: AppTheme.textSlate400,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        if (recents.isEmpty)
           const Text("Nothing yet. Add something below.", style: TextStyle(color: AppTheme.textSlate400, fontSize: 12)),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: recents.map((item) {
            String label = "";
            if (item is Decision) label = item.title;
            else if (item is ContextMemory) label = item.entityName;
            
            if (label.length > 15) label = "${label.substring(0, 12)}...";

            return GestureDetector(
              onTap: () {
                 if (item is Decision) Navigator.push(context, MaterialPageRoute(builder: (_) => RecallDetailScreen(item: item)));
                 else if (item is ContextMemory) Navigator.push(context, MaterialPageRoute(builder: (_) => RecallDetailScreen(item: item)));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
            );
          }).toList(),
        ).animate().fadeIn(delay: 400.ms),

        const Spacer(flex: 3),

        // Bottom Action Cards
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                label: "Add Decision",
                icon: Icons.balance,
                color: const Color(0xFF1E293B),
                iconColor: Colors.blueAccent,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddDecisionScreen())),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ActionCard(
                label: "Add Memory",
                icon: Icons.psychology, 
                color: const Color(0xFF1E293B),
                iconColor: Colors.cyanAccent,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMemoryScreen())),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
      ],
    );
  }

  Widget _buildSearchResults(BuildContext context, AsyncValue<List<RecallResult>> resultsAsync) {
    return resultsAsync.when(
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wind_power, color: AppTheme.textSlate400, size: 48),
                const SizedBox(height: 16),
                const Text(
                  "No memory found.\nSave it once to stop thinking.",
                  style: TextStyle(color: AppTheme.textSlate400, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: results.length,
          separatorBuilder: (c, i) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final result = results[index];
            void openDetail() {
               if (result is ValDecision) Navigator.of(context).push(MaterialPageRoute(builder: (c) => RecallDetailScreen(item: result.decision)));
               else if (result is ValMemory) Navigator.of(context).push(MaterialPageRoute(builder: (c) => RecallDetailScreen(item: result.memory)));
            }

            return GestureDetector(
              onTap: openDetail,
              child: GlassContainer(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                opacity: 0.03, // Very subtle
                child: switch (result) {
                  ValDecision(decision: final d) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    title: Text(d.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    subtitle: Text("Choice: ${d.finalChoice}", style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.check, color: AppTheme.primary, size: 16),
                    ),
                  ),
                  ValMemory(memory: final m) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    title: Text(m.entityName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    subtitle: Text(m.memory, style: const TextStyle(color: AppTheme.textSlate300), maxLines: 2, overflow: TextOverflow.ellipsis),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), shape: BoxShape.circle),
                      child: const Icon(Icons.lightbulb, color: Colors.amberAccent, size: 16),
                    ),
                  ),
                  ValSuggestion(suggestion: final s) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    title: const Text("AI Insight", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF9D4EDD))),
                    subtitle: Text(s, style: const TextStyle(color: AppTheme.textSlate300, fontStyle: FontStyle.italic)),
                    leading: const Icon(Icons.auto_awesome, color: Color(0xFF9D4EDD))
                    .animate(onPlay: (c) => c.repeat()).shimmer(duration: 2000.ms, color: Colors.white24),
                  ),
                },
              ),
            ).animate().fadeIn(duration: 400.ms, delay: (50 * index).ms).slideY(begin: 0.1, end: 0);
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator(color: AppTheme.primary)), 
      error: (err, stack) => Text('Error: $err', style: const TextStyle(color: Colors.red)),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
             BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0,4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
