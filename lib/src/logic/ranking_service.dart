import '../domain/models/decision.dart';
import '../domain/models/context_memory.dart';
import '../domain/models/recall_result.dart';
import 'intent_detection_service.dart';

class RankingService {
  final _intentService = IntentDetectionService();

  Future<List<RecallResult>> rank({
    required String query,
    required List<Decision> decisions,
    required List<ContextMemory> memories,
  }) async {
    final normalizedQuery = query.toLowerCase().trim();
    if (normalizedQuery.isEmpty) {
      // Default: Show recent/favorites
      final topDecisions = [...decisions]
        ..sort((a, b) => b.reuseCount.compareTo(a.reuseCount)); // simple sort
      
      final recentMemories = [...memories]
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        
      return [
        ...topDecisions.take(3).map((d) => RecallResult.valDecision(d)),
        ...recentMemories.take(3).map((m) => RecallResult.valMemory(m)),
      ];
    }

    // 1. Detect Intent (Async AI check)
    final intent = await _intentService.detectIntent(query);

    // 2. Filter & Score
    final matchedDecisions = decisions
        .where((d) => _matchesDecision(d, normalizedQuery))
        .map((d) => (item: d, score: _scoreDecision(d, intent)))
        .toList();

    final matchedMemories = memories
        .where((m) => _matchesMemory(m, normalizedQuery))
        .map((m) => (item: m, score: _scoreMemory(m, intent)))
        .toList();

    // 3. Sort by Score
    matchedDecisions.sort((a, b) => b.score.compareTo(a.score));
    matchedMemories.sort((a, b) => b.score.compareTo(a.score));

    // 4. Merge based on Intent
    List<RecallResult> results = [];
    
    // AI Thinking Step (Generative Recommendation)
    if (intent == UserIntent.decision && decisions.isNotEmpty) {
      // Only ask if we have some history to base it on
       final historySample = decisions
          .take(10) // Take last 10 decisions
          .map((d) => {'title': d.title, 'choice': d.finalChoice, 'tags': d.contextTags})
          .toList();
          
       final memorySample = memories
          .map((m) => {'entity': m.entityName, 'content': m.memory, 'tags': m.tags})
          .toList();
          
       // Fire and forget? No, user wants to see it.
       // We can append it to the top.
       // Note: This adds latency. Ideally we stream it.
       final aiSuggestion = await _intentService.getRecommendation(query, historySample, memorySample);
       if (aiSuggestion != null) {
         results.add(RecallResult.valSuggestion(aiSuggestion));
       }
    }
    
    if (intent == UserIntent.decision) {
      // Prioritize Decisions heavily
      results.addAll(matchedDecisions.map((e) => RecallResult.valDecision(e.item)));
      results.addAll(matchedMemories.map((e) => RecallResult.valMemory(e.item)));
    } else if (intent == UserIntent.recall) {
      // Prioritize Memories heavily
      results.addAll(matchedMemories.map((e) => RecallResult.valMemory(e.item)));
      results.addAll(matchedDecisions.map((e) => RecallResult.valDecision(e.item)));
    } else {
      // Ambiguous: Mix based on raw score
      final all = [
        ...matchedDecisions.map((e) => (res: RecallResult.valDecision(e.item), score: e.score)),
        ...matchedMemories.map((e) => (res: RecallResult.valMemory(e.item), score: e.score)),
      ];
      all.sort((a, b) => b.score.compareTo(a.score));
      results = all.map((e) => e.res).toList();
    }

    return results;
  }

  bool _matchesDecision(Decision d, String query) {
    if (_matchesTokens(d.title, query)) return true;
    if (d.category != null && _matchesTokens(d.category!, query)) return true;
    if (d.contextTags.any((t) => _matchesTokens(t, query))) return true;
    return false;
  }

  bool _matchesMemory(ContextMemory m, String query) {
    if (_matchesTokens(m.entityName, query)) return true;
    if (_matchesTokens(m.memory, query)) return true;
    if (m.tags.any((t) => _matchesTokens(t, query))) return true;
    return false;
  }

  bool _matchesTokens(String target, String query) {
    // 1. Exact/Substring Match (Fast)
    final t = target.toLowerCase();
    if (t.isEmpty) return false;
    
    // Bi-directional substring check
    if (t.contains(query) || (t.length > 2 && query.contains(t))) return true;

    // 2. Token Intersection (Fuzzy)
    // "when is rohit birthday" vs "rohit birthday"
    final queryTokens = query.split(' ').where((e) => e.isNotEmpty).toSet();
    final targetTokens = t.split(' ').where((e) => e.isNotEmpty).toSet();
    
    // If query has 'rohit' and 'birthday', and target is 'rohit birthday' -> 100% match of target
    final intersection = queryTokens.intersection(targetTokens);
    
    // If we matched all significant words in the target (e.g. "rohit", "birthday")
    if (intersection.length == targetTokens.length) return true;
    
    // If we matched at least 2 words (e.g. "rohit", "birthday" in "rohit happy birthday")
    if (intersection.length >= 2) return true;

    // 3. Short Query Exception
    // If query is short (e.g. "suggest movies") and we match 1 significant word ("movies" > 3 chars)
    if (queryTokens.length <= 2 && intersection.isNotEmpty && intersection.first.length > 3) {
      return true;
    }
    
    return false;
  }

  double _scoreDecision(Decision d, UserIntent intent) {
    double score = (d.successScore * 2) + d.reuseCount + (d.isDefault ? 10.0 : 0.0);
    // Boost if intent matches
    if (intent == UserIntent.decision) score += 50.0; 
    return score;
  }

  double _scoreMemory(ContextMemory m, UserIntent intent) {
    double score = 10.0;
    if (m.priority.toLowerCase() == 'high') score = 30.0;
    if (m.priority.toLowerCase() == 'medium') score = 20.0;
    
    // Boost if intent matches
    if (intent == UserIntent.recall) score += 50.0;
    return score;
  }
}
