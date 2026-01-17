import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../providers/decision_provider.dart';
import '../providers/memory_provider.dart';
import '../../domain/models/decision.dart';
import '../../domain/models/context_memory.dart';
import 'recall_detail_screen.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String _filter = "All"; // All, Decisions, Memories

  @override
  Widget build(BuildContext context) {
    // 1. Fetch Data
    final decisionsAsync = ref.watch(decisionsProvider);
    final memoriesAsync = ref.watch(memoriesProvider);

    final decisions = decisionsAsync.valueOrNull ?? [];
    final memories = memoriesAsync.valueOrNull ?? [];

    // 2. Merge & Sort
    final List<dynamic> combined = [];
    if (_filter == "All" || _filter == "Decisions") combined.addAll(decisions);
    if (_filter == "All" || _filter == "Memories") combined.addAll(memories);

    combined.sort((a, b) {
       DateTime dateA, dateB;
       if (a is Decision) dateA = a.createdAt;
       else dateA = (a as ContextMemory).createdAt;

       if (b is Decision) dateB = b.createdAt;
       else dateB = (b as ContextMemory).createdAt;

       return dateB.compareTo(dateA); // Descending
    });

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundDark.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("History", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [
          IconButton(
            icon: const CircleAvatar(backgroundColor: Colors.white10, child: Icon(Icons.search, color: Colors.white, size: 20)),
            onPressed: () {}, // Future: Implement search filter
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Segmented Control
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(child: _SegmentButton(label: "All", isActive: _filter == "All", onTap: () => setState(() => _filter = "All"))),
                    Expanded(child: _SegmentButton(label: "Decisions", isActive: _filter == "Decisions", onTap: () => setState(() => _filter = "Decisions"))),
                    Expanded(child: _SegmentButton(label: "Memories", isActive: _filter == "Memories", onTap: () => setState(() => _filter = "Memories"))),
                  ],
                ),
              ),
            ),
            
            // List
            Expanded(
              child: combined.isEmpty 
              ? Center(child: Text("No history yet.", style: TextStyle(color: AppTheme.textSlate400)))
              : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                itemCount: combined.length,
                itemBuilder: (context, index) {
                  final item = combined[index];
                  final isDecision = item is Decision;
                  
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => RecallDetailScreen(item: item))),
                    child: _HistoryCard(
                      icon: isDecision ? Icons.call_split : Icons.lightbulb,
                      title: isDecision ? (item as Decision).title : (item as ContextMemory).entityName,
                      subtitle: isDecision ? (item as Decision).finalChoice : (item as ContextMemory).memory,
                      time: DateFormat('MMM d, h:mm a').format(isDecision ? (item as Decision).createdAt : (item as ContextMemory).createdAt),
                      isDecision: isDecision,
                    ).animate().fadeIn(duration: 300.ms, delay: (50 * index).ms).slideY(begin: 0.1, end: 0),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _SegmentButton({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: isActive 
            ? BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)])
            : null,
        child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isActive ? Colors.white : AppTheme.textSlate400)),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(label, style: const TextStyle(color: AppTheme.textSlate400, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.5)),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool isDecision;

  const _HistoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isDecision,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.02)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: isDecision ? AppTheme.primary.withOpacity(0.1) : Colors.purpleAccent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isDecision ? AppTheme.primary : Colors.purpleAccent, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                     Text(time, style: const TextStyle(color: AppTheme.textSlate400, fontSize: 10, fontWeight: FontWeight.bold)),
                   ],
                 ),
                 const SizedBox(height: 4),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Expanded(child: Text(subtitle, style: TextStyle(color: isDecision ? AppTheme.primary : AppTheme.textSlate300, fontSize: 14))),
                     if (isDecision)
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                         decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: AppTheme.primary.withOpacity(0.2))),
                         child: const Row(children: [Icon(Icons.replay, size: 10, color: AppTheme.primary), SizedBox(width: 2), Text("2x", style: TextStyle(fontSize: 8, color: AppTheme.primary, fontWeight: FontWeight.bold))]),
                       )
                   ],
                 )
              ],
            ),
          )
        ],
      ),
    );
  }
}
