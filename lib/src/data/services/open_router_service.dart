import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenRouterService {
  static final OpenRouterService _instance = OpenRouterService._internal();
  factory OpenRouterService() => _instance;
  OpenRouterService._internal();

  static const String _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  
  // Using Gemini Flash as planned - Fast & Cheap
  static const String _model = 'google/gemini-2.0-flash-001';

  Future<String?> classifyIntent(String query) async {
    final apiKey = dotenv.env['OPENROUTER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      print('WARNING: OpenRouter API Key missing.');
      return null;
    }
    print('DEBUG: Using OpenRouter Key: ${apiKey.substring(0, 15)}...');

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://nothink.app', // Required by OpenRouter
          'X-Title': 'NoThink',
        },
        body: jsonEncode({
          'model': _model,
          'messages': [
            {
              'role': 'system',
              'content': '''
You are an intent classifier for a personal memory app.
Classify the user query into one of these categories:
- DECISION: The user is asking for a choice, suggestion, or picking something (e.g., "what to eat", "pick a movie", "wear").
- RECALL: The user is asking to remember a fact, code, location, or person (e.g., "who is...", "gate code", "wifi password").
- AMBIGUOUS: It is unclear or neither.

Return ONLY a JSON object: {"intent": "DECISION" | "RECALL" | "AMBIGUOUS"}
'''
            },
            {
              'role': 'user',
              'content': query
            }
          ],
          'temperature': 0.1, // Deterministic
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];
        // Parse JSON from content (it might be wrapped in markdown code blocks by some models)
        final cleanContent = content.toString().replaceAll('```json', '').replaceAll('```', '').trim();
        final json = jsonDecode(cleanContent);
        return json['intent'];
      } else {
        print('OpenRouter Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('OpenRouter Exception: $e');
      return null;
    }
  }

  Future<String?> getDecisionRecommendation(String query, List<Map<String, dynamic>> history, List<Map<String, dynamic>> memories) async {
    final apiKey = dotenv.env['OPENROUTER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) return null;

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://nothink.app',
          'X-Title': 'NoThink',
        },
        body: jsonEncode({
          'model': _model,
          'messages': [
            {
              'role': 'system',
              'content': 'You are a helpful assistant for a decision/memory app. You are given a user query, a history of past decisions, and stored context memories. Synthesize a personalized recommendation by combining these inputs. Be concise (max 2 sentences). Start with "Based on your history and memories..."'
            },
            {
              'role': 'user',
              'content': 'Query: "$query"\nDecision History: ${jsonEncode(history)}\nMemories: ${jsonEncode(memories)}'
            }
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      }
    } catch (e) {
      print('AI Rec Error: $e');
    }
    return null;
  }
}
