import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/decision.dart';
import '../providers/decision_provider.dart';

class AddDecisionScreen extends ConsumerStatefulWidget {
  const AddDecisionScreen({super.key});

  @override
  ConsumerState<AddDecisionScreen> createState() => _AddDecisionScreenState();
}

class _AddDecisionScreenState extends ConsumerState<AddDecisionScreen> {
  final _titleController = TextEditingController();
  final _choiceController = TextEditingController();
  
  // Tag state (Mocked for UI as per design)
  final List<String> _tags = ["Food", "Work", "Health"];
  String _selectedTag = "Food";

  void _save() {
    if (_titleController.text.isEmpty || _choiceController.text.isEmpty) return;

    final decision = Decision(
      id: const Uuid().v4(),
      userId: 'current_user',
      title: _titleController.text,
      finalChoice: _choiceController.text,
      category: _selectedTag,
      createdAt: DateTime.now(),
      lastUsedAt: DateTime.now(),
    );

    ref.read(decisionsProvider.notifier).addDecision(decision);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("New Rule", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: The Trigger
                  Text(
                    "When I need to decide...",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
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
                    child: TextField(
                      controller: _titleController,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "e.g., What to eat for lunch on workdays?",
                        hintStyle: const TextStyle(color: AppTheme.textSlate400),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.edit_note, color: AppTheme.textSlate400),
                        ),
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  
                  // Visual Connector
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Icon(Icons.arrow_downward, size: 32, color: AppTheme.textSlate400),
                    ),
                  ),

                  // Section 2: The Choice
                  Text(
                    "...the answer is always:",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
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
                    child: TextField(
                      controller: _choiceController,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primary),
                      decoration: InputDecoration(
                        hintText: "e.g., Dal + Rice",
                        hintStyle: const TextStyle(color: AppTheme.textSlate400),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.check_circle, color: AppTheme.primary),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  const Divider(color: Color(0xFF2A3642)),
                  const SizedBox(height: 24),

                  // Section 3: Context & Settings
                  Text(
                    "CONTEXT",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSlate400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (final tag in _tags)
                        ChoiceChip(
                          label: Text(tag),
                          selected: _selectedTag == tag,
                          onSelected: (selected) => setState(() => _selectedTag = tag),
                          selectedColor: AppTheme.primary,
                          backgroundColor: AppTheme.surfaceDark,
                          labelStyle: TextStyle(
                            color: _selectedTag == tag ? Colors.white : AppTheme.textSlate300,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide.none,
                          ),
                          avatar: _selectedTag == tag ? null : const Icon(Icons.tag, size: 16, color: AppTheme.textSlate400),
                        ),
                       IconButton(
                         icon: const Icon(Icons.add, color: AppTheme.textSlate400),
                         onPressed: () {
                           showDialog(
                             context: context,
                             builder: (context) {
                               String newTag = "";
                               return AlertDialog(
                                 backgroundColor: AppTheme.surfaceDark,
                                 title: const Text("Add New Tag", style: TextStyle(color: Colors.white)),
                                 content: TextField(
                                   autofocus: true,
                                   style: const TextStyle(color: Colors.white),
                                   onChanged: (v) => newTag = v,
                                   decoration: const InputDecoration(
                                     hintText: "Tag name",
                                     hintStyle: TextStyle(color: AppTheme.textSlate400),
                                     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),
                                   ),
                                 ),
                                 actions: [
                                   TextButton(
                                     onPressed: () => Navigator.pop(context),
                                     child: const Text("Cancel", style: TextStyle(color: AppTheme.textSlate400)),
                                   ),
                                   TextButton(
                                     onPressed: () {
                                       if (newTag.isNotEmpty) {
                                         setState(() {
                                           _tags.add(newTag);
                                           _selectedTag = newTag;
                                         });
                                       }
                                       Navigator.pop(context);
                                     },
                                     child: const Text("Add", style: TextStyle(color: AppTheme.primary)),
                                   ),
                                 ],
                               );
                             },
                           );
                         }, 
                       ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Lock this decision", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("Always apply this rule automatically", style: TextStyle(color: AppTheme.textSlate400, fontSize: 12)),
                        ],
                      ),
                      Switch(
                        value: true, 
                        onChanged: (v) {},
                        activeColor: AppTheme.primary,
                        activeTrackColor: AppTheme.surfaceDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom FAB Area
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppTheme.backgroundDark,
                  AppTheme.backgroundDark.withOpacity(0.0),
                ],
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text("Confirm & Forget"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
