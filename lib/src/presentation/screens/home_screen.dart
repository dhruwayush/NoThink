import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../providers/ranking_provider.dart';
import '../providers/query_provider.dart';
import '../../domain/models/recall_result.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/models/decision.dart'; // For detail casting
import '../../domain/models/context_memory.dart'; // For detail casting

import 'add_decision_screen.dart';
import 'add_memory_screen.dart';
import 'settings_screen.dart';
import 'history_screen.dart';
import 'recall_detail_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchKey = GlobalObjectKey('search_input_stable');

  @override
  Widget build(BuildContext context) {
    // Only watch what is needed for the list/empty state
    final recallResultsAsync = ref.watch(rankingProvider);
    final query = ref.watch(queryProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Top Status Bar Area
              const SizedBox(height: 12),
              
              // Header / Branding
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   IconButton(
                     icon: const Icon(Icons.settings, color: Colors.white54),
                     onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const SettingsScreen())),
                   ),
                   Row(
                     children: [
                       Icon(Icons.radio_button_checked, color: AppTheme.primary, size: 24),
                       const SizedBox(width: 8),
                       Text(
                         "NOTHINK",
                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
                           letterSpacing: 2.0,
                           fontWeight: FontWeight.bold,
                           color: Colors.white.withOpacity(0.5),
                         ),
                       ),
                     ],
                   ),
                   IconButton(
                     icon: const Icon(Icons.history, color: Colors.white54),
                     onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const HistoryScreen())),
                   ),
                ],
              ),
              
              const Spacer(flex: 2),

              // Hero Input Section
              if (query.isEmpty && recallResultsAsync.valueOrNull?.isEmpty == true) ...[
                Text(
                  "What do you want to recall?",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppTheme.textSlate400,
                  ),
                  textAlign: TextAlign.center,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w300,
                      color: AppTheme.textSlate400,
                    ),
                    children: [
                       const TextSpan(text: "What do you want to "),
                       TextSpan(text: "recall", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                       const TextSpan(text: "?"),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
              
              // Search Input
              _SearchInput(key: _searchKey),
              const SizedBox(height: 32),

              // Results List or Recent Chips
              Expanded(
                flex: 3,
                child: recallResultsAsync.when(
                  data: (results) {
                    if (results.isEmpty && query.isEmpty) {
                      // Recent Recalls Section (Mocked for UI)
                      return Column(
                        children: [
                          Opacity(
                            opacity: 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.history, size: 16, color: AppTheme.textSlate400),
                                const SizedBox(width: 8),
                                Text(
                                  "RECENT RECALLS",
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    letterSpacing: 1.5,
                                    color: AppTheme.textSlate400,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: [
                              _RecentChip(label: "Rohit"),
                              _RecentChip(label: "Lunch plans"),
                              _RecentChip(label: "Project X"),
                            ],
                          ),
                        ],
                      );
                    }

                    if (results.isEmpty && query.isNotEmpty) {
                      return Center(
                        child: Text(
                          "No memory saved. Save once to stop thinking next time.",
                          style: TextStyle(color: AppTheme.textSlate400),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (c, i) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final result = results[index];
                        // Helper to navigate to Detail
                        void openDetail() {
                           if (result is ValDecision) {
                             Navigator.of(context).push(MaterialPageRoute(builder: (c) => RecallDetailScreen(item: result.decision)));
                           } else if (result is ValMemory) {
                             Navigator.of(context).push(MaterialPageRoute(builder: (c) => RecallDetailScreen(item: result.memory)));
                           }
                        }

                        return GestureDetector(
                          onTap: openDetail,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceDark,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: switch (result) {
                              ValDecision(decision: final d) => ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: Text(d.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text("Choice: ${d.finalChoice}", style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Color(0xFF1E2832),
                                  child: Icon(Icons.check_circle, color: AppTheme.primary),
                                ),
                              ),
                              ValMemory(memory: final m) => ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: Text(m.entityName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(m.memory, style: const TextStyle(color: AppTheme.textSlate300)),
                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Color(0xFF1E2832),
                                  child: Icon(Icons.lightbulb, color: Colors.amberAccent),
                                ),
                              ),
                              ValSuggestion(suggestion: final s) => ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: const Text("AI Insight", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF9D4EDD))),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(s, style: const TextStyle(color: AppTheme.textSlate300, fontStyle: FontStyle.italic)),
                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Color(0xFF2E1A47),
                                  child: Icon(Icons.auto_awesome, color: Color(0xFF9D4EDD)),
                                )
                                .animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 2000.ms, color: Colors.white24),
                              ),
                            },
                          ).animate().fadeIn(duration: 400.ms, delay: (50 * index).ms).slideY(begin: 0.1, end: 0),
                        );
                      },
                    );
                  },
                  loading: () => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.auto_awesome, color: AppTheme.primary, size: 48)
                          .animate(onPlay: (controller) => controller.repeat(reverse: true))
                          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 1000.ms)
                          .fadeIn(duration: 500.ms),
                        const SizedBox(height: 16),
                        const Text("Thinking...", style: TextStyle(color: AppTheme.textSlate400))
                          .animate()
                          .fadeIn(delay: 500.ms),
                      ],
                    ),
                  ),
                  error: (err, stack) => Text('Error: $err'),
                ),
              ),
              
              const Spacer(),
              
              // Bottom Action Bar
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.balance,
                        label: "Add Decision",
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const AddDecisionScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.psychology,
                        label: "Add Memory",
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const AddMemoryScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchInput extends ConsumerStatefulWidget {
  const _SearchInput({super.key});

  @override
  ConsumerState<_SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<_SearchInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sync controller if provider changes externally (though mainly for initial state)
    final query = ref.watch(queryProvider);
    if (_controller.text != query) {
       _controller.text = query;
       // keep cursor at end if text changed externally
       _controller.selection = TextSelection.fromPosition(TextPosition(offset: query.length));
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        key: const Key('search_input_field'),
        controller: _controller,
        focusNode: _focusNode,
        onChanged: (value) {
           ref.read(queryProvider.notifier).setQuery(value);
        },
        decoration: InputDecoration(
          hintText: 'Type keywords...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.textSlate400.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('⌘K', style: TextStyle(fontSize: 12, color: AppTheme.textSlate400)),
            ),
          ),
          fillColor: Colors.transparent, 
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: const TextStyle(color: AppTheme.textSlate400),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
        style: const TextStyle(fontSize: 18),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}

class _RecentChip extends StatelessWidget {
  final String label;
  const _RecentChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label, 
        style: const TextStyle(color: AppTheme.textSlate300, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({required this.icon, required this.label, required this.onPressed});

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: 100.ms,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(16),
             boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.primary.withOpacity(0.1),
                child: Icon(widget.icon, color: AppTheme.primary),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.textSlate300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
