import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/context_memory.dart';
import '../providers/memory_provider.dart';

class AddMemoryScreen extends ConsumerStatefulWidget {
  const AddMemoryScreen({super.key});

  @override
  ConsumerState<AddMemoryScreen> createState() => _AddMemoryScreenState();
}

class _AddMemoryScreenState extends ConsumerState<AddMemoryScreen> {
  final _entityNameController = TextEditingController();
  final _memoryController = TextEditingController();
  // ignore: unused_field
  final String _entityType = 'person'; // Defaulting to person for UI simplicity in this redesign

  void _save() {
    if (_entityNameController.text.isEmpty || _memoryController.text.isEmpty) return;

    final memory = ContextMemory(
      id: const Uuid().v4(),
      userId: 'current_user',
      entityType: _entityType,
      entityName: _entityNameController.text,
      memory: _memoryController.text,
      createdAt: DateTime.now(),
    );

    ref.read(memoriesProvider.notifier).addMemory(memory);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      // Custom App Bar Layout
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "New Memory", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Entity Section
                    Row(
                      children: [
                        const Icon(Icons.person_pin, color: AppTheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "Entity",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
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
                        controller: _entityNameController,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                        decoration: InputDecoration(
                           hintText: "Who or what is this about? (e.g. Rohit, Gym)",
                           hintStyle: const TextStyle(color: AppTheme.textSlate400),
                           border: InputBorder.none,
                           contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Memory Section
                    Row(
                      children: [
                         const Icon(Icons.sticky_note_2, color: AppTheme.primary, size: 20),
                         const SizedBox(width: 8),
                         Text(
                           "Memory",
                           style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                         ),
                      ],
                    ),
                    const SizedBox(height: 12),
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
                        controller: _memoryController,
                        maxLines: 8,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                        decoration: InputDecoration(
                           hintText: "What specific details do you need to remember? Context is key.",
                           hintStyle: const TextStyle(color: AppTheme.textSlate400),
                           border: InputBorder.none,
                           contentPadding: const EdgeInsets.all(20),
                        ),
                    ),
                     ),
                    const SizedBox(height: 24),

                    // Tags Section (Visual only)
                    Row(
                      children: [
                        const Icon(Icons.label, color: AppTheme.primary, size: 18),
                        const SizedBox(width: 8),
                        Text("Tags", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(width: 8),
                        Text("(Optional)", style: TextStyle(color: AppTheme.textSlate400, fontSize: 12)),
                      ],
                    ),
                     const SizedBox(height: 12),
                     SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                       child: Row(
                         children: [
                           // Add Tag Input Placeholder
                           Container(
                             width: 150,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             decoration: BoxDecoration(
                               color: AppTheme.surfaceDark,
                               borderRadius: BorderRadius.circular(12),
                             ),
                             child: TextField(
                               decoration: InputDecoration(
                                 icon: Icon(Icons.tag, color: AppTheme.textSlate400, size: 20),
                                 hintText: "Add tag...",
                                 border: InputBorder.none,
                                 fillColor: Colors.transparent, // override theme
                                 contentPadding: const EdgeInsets.symmetric(vertical: 12),
                               ),
                             ),
                           ),
                           const SizedBox(width: 12),
                           _TagChip(label: "#work"),
                           const SizedBox(width: 8),
                           _TagChip(label: "#ideas"),
                           const SizedBox(width: 8),
                           _TagChip(label: "#people"),
                         ],
                       ),
                     ),
                     const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: AppTheme.backgroundDark.withOpacity(0.9), // slight transparency for overlap feel
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text("Save Memory"),
          ),
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(color: AppTheme.textSlate300, fontWeight: FontWeight.bold),
      ),
    );
  }
}
