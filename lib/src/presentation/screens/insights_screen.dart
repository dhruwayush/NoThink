import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../providers/decision_provider.dart';
import '../widgets/glass_container.dart';
import 'settings_screen.dart';

class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> {
  int _selectedTab = 1; // 0=Weekly, 1=Monthly, 2=All-Time

  @override
  Widget build(BuildContext context) {
    final decisionsAsync = ref.watch(decisionsProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Insights", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white70),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const SettingsScreen())),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: decisionsAsync.when(
        data: (decisions) {
          final totalDecisions = decisions.length;
          // Sort by usage count for "Top 5"
          // Assuming we might have a reuseCount or similar, or just using raw list for now.
          // In the current model, we have `lastUsedAt`. We don't have an explicit `reuseCount` in the basic model shown previously
          // Wait, I saw `reuseCount` in `decision.dart` earlier? 
          // Checking memory... `decision.dart` had `reuseCount`. Yes.
          
          final sortedDecisions = List.of(decisions);
          sortedDecisions.sort((a, b) => b.reuseCount.compareTo(a.reuseCount)); // Descending
          final topDecisions = sortedDecisions.take(5).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Segmented Control
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      _TabButton(label: "Weekly", isSelected: _selectedTab == 0, onTap: () => setState(() => _selectedTab = 0)),
                      _TabButton(label: "Monthly", isSelected: _selectedTab == 1, onTap: () => setState(() => _selectedTab = 1)),
                      _TabButton(label: "All-Time", isSelected: _selectedTab == 2, onTap: () => setState(() => _selectedTab = 2)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),

                // 2. Cognitive Load Card
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF132230),
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Stack(
                    children: [
                      // Graph Background
                      Positioned.fill(
                        top: 80,
                        child: CustomPaint(
                          painter: _GraphPainter(color: AppTheme.primary),
                        ),
                      ).animate().fadeIn(duration: 1000.ms),
                      
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.psychology, color: Colors.cyanAccent, size: 20),
                                SizedBox(width: 8),
                                Text("COGNITIVE LOAD REDUCED", style: TextStyle(color: AppTheme.textSlate400, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("$totalDecisions", style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                const Text("Decisions", style: TextStyle(color: AppTheme.textSlate300, fontSize: 18)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              children: [
                                Icon(Icons.trending_up, color: Colors.cyanAccent, size: 16),
                                SizedBox(width: 4),
                                Text("+15% vs last month", style: TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),

                const SizedBox(height: 32),

                // 3. Top Reused Decisions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Top 5 Reused Decisions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    TextButton(onPressed: (){}, child: const Text("View all", style: TextStyle(color: Colors.cyanAccent))),
                  ],
                ),
                const SizedBox(height: 12),
                
                if (topDecisions.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text("No data yet. Start making decisions!", style: TextStyle(color: AppTheme.textSlate400))),
                  )
                else
                  Column(
                    children: topDecisions.map((decision) {
                      final cat = decision.category?.toLowerCase() ?? "";
                      IconData catIcon = Icons.lightbulb_outline;
                      if (cat.contains("food") || cat.contains("eat") || cat.contains("dining")) catIcon = Icons.restaurant;
                      else if (cat.contains("work") || cat.contains("office") || cat.contains("job")) catIcon = Icons.work;
                      else if (cat.contains("gym") || cat.contains("health") || cat.contains("fit")) catIcon = Icons.fitness_center;
                      else if (cat.contains("money") || cat.contains("finance")) catIcon = Icons.attach_money;
                      else if (cat.contains("shop")) catIcon = Icons.shopping_cart;
                      else if (cat.contains("travel") || cat.contains("trip")) catIcon = Icons.flight;
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(catIcon, color: Colors.cyanAccent.withOpacity(0.8), size: 20),
                          ),
                          title: Text(decision.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          subtitle: Text(decision.category ?? "General", style: const TextStyle(color: AppTheme.textSlate400)),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${decision.reuseCount}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                              const Text("TIMES", style: TextStyle(fontSize: 8, color: AppTheme.textSlate400)),
                            ],
                          ),
                        ),
                      );
                    }).toList().animate(interval: 100.ms).fadeIn().slideX(),
                  ),

                const SizedBox(height: 32),

                // 4. High Friction Areas / Most Active Category
                const Text("High Friction Areas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 12),
                
                Builder(
                  builder: (context) {
                    // Calculate Category Stats
                    final categoryCounts = <String, int>{};
                    for (final d in decisions) {
                      final cat = d.category?.trim() ?? "Uncategorized";
                      if (cat.isNotEmpty) {
                        categoryCounts[cat] = (categoryCounts[cat] ?? 0) + 1;
                      }
                    }

                    if (categoryCounts.isEmpty) {
                       return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(20)),
                        child: const Center(child: Text("Add categories to your decisions to see insights here.", style: TextStyle(color: AppTheme.textSlate400))),
                       );
                    }

                    var topCategory = "";
                    var topCount = 0;
                    categoryCounts.forEach((key, value) {
                      if (value > topCount) {
                        topCount = value;
                        topCategory = key;
                      }
                    });
                    
                    final double percentage = totalDecisions > 0 ? topCount / totalDecisions : 0.0;
                    final percentageStr = (percentage * 100).toStringAsFixed(0);

                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceDark,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("MOST ACTIVE CATEGORY", style: TextStyle(color: AppTheme.textSlate400, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                                  const SizedBox(height: 4),
                                  Text(topCategory, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.2), shape: BoxShape.circle),
                                child: const Icon(Icons.analytics, color: Colors.redAccent),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("$topCount Decisions", style: const TextStyle(color: Colors.white70)),
                              Text("$percentageStr% of total", style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: percentage,
                              backgroundColor: Colors.white10,
                              color: Colors.redAccent,
                              minHeight: 6,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "\"You have created $topCount rules for $topCategory. Keep optimizing!\"",
                            style: const TextStyle(color: AppTheme.textSlate300, fontStyle: FontStyle.italic, fontSize: 13),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0);
                  }
                ),
                
                const SizedBox(height: 40),
                const Center(
                   child: Text(
                     "\"The best decisions are the ones\nyou don't have to make twice.\"",
                     textAlign: TextAlign.center,
                     style: TextStyle(color: AppTheme.textSlate400, fontStyle: FontStyle.italic),
                   ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text("Error: $e")),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.cyan : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : AppTheme.textSlate400,
            ),
          ),
        ),
      ),
    );
  }
}

class _GraphPainter extends CustomPainter {
  final Color color;
  _GraphPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Simple S-curve mock
    path.moveTo(0, size.height * 0.8);
    path.cubicTo(
      size.width * 0.3, size.height * 0.7, 
      size.width * 0.6, size.height * 0.9, 
      size.width, size.height * 0.2
    );

    canvas.drawPath(path, paint);

    // Gradient Fill
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color.withOpacity(0.2), Colors.transparent],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, Paint()..shader = gradient);
    
    // End Dot
    canvas.drawCircle(Offset(size.width, size.height * 0.2), 4, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
