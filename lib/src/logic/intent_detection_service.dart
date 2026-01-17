import '../data/services/open_router_service.dart';

enum UserIntent {
  decision, // User wants to make a choice (What should I eat?)
  recall,   // User wants specific info (What is the gate code?)
  ambiguous // Unclear, search everything
}

class IntentDetectionService {
  final _aiService = OpenRouterService();

  Future<String?> getRecommendation(String query, List<Map<String, dynamic>> history, List<Map<String, dynamic>> memories) async {
    return _aiService.getDecisionRecommendation(query, history, memories);
  }

  Future<UserIntent> detectIntent(String query) async {
    if (query.isEmpty) return UserIntent.ambiguous;

    final lowerQuery = query.toLowerCase().trim();

    // 1. Fast Local Heuristics (Regex/Keywords)
    // Priority: Explicit triggers are usually correct and much faster than AI.
    
    // Explicit Decision Triggers
    if (lowerQuery.startsWith("what should") ||
        lowerQuery.startsWith("which") ||
        lowerQuery.startsWith("pick") ||
        lowerQuery.startsWith("choose") ||
        lowerQuery.contains("decision")) {
      return UserIntent.decision;
    }

    // Explicit Recall Triggers
    if (lowerQuery.startsWith("who") ||
        lowerQuery.startsWith("where") ||
        lowerQuery.contains("password") ||
        lowerQuery.contains("code") ||
        lowerQuery.contains("wifi") ||
        lowerQuery.contains("detail") ||
        lowerQuery.contains("pin")) {
      return UserIntent.recall;
    }
    
    // If local check is Ambiguous, Ask AI
    if (query.trim().split(' ').length > 1) {
       final aiResult = await _aiService.classifyIntent(query);
       
       if (aiResult != null) {
         if (aiResult == 'DECISION') return UserIntent.decision;
         if (aiResult == 'RECALL') return UserIntent.recall;
       }
    }

    // Default or Fallback
    return UserIntent.ambiguous;
  }
}
