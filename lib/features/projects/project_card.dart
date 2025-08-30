import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/services/resume_models.dart';
import '../../core/widgets/chip.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with TickerProviderStateMixin {
  bool _isExpanded = false;
  final ScrollController _bodyCtrl = ScrollController();

  @override
  void dispose() {
    _bodyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() => _isExpanded = !_isExpanded);
          HapticFeedback.lightImpact();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max, // fill the grid cell
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Header (fixed height) ----------
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.project.name,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.open_in_new),
                    tooltip: 'Open',
                    onPressed: () {
                      // TODO: url_launcher
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening ${widget.project.url}')));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ---------- Scrollable body (prevents overflow) ----------
              Expanded(
                child: Scrollbar(
                  controller: _bodyCtrl, // <-- same controller
                  thumbVisibility: _isExpanded, // show thumb when expanded
                  child: SingleChildScrollView(
                    controller: _bodyCtrl, // <-- attaches the position
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description (trim when collapsed)
                        Text(
                          widget.project.description,
                          style: theme.textTheme.bodyMedium,
                          maxLines: _isExpanded ? null : 3,
                          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),

                        // Tech chips
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: widget.project.tech.map((tech) {
                            return AppChip(
                              label: tech,
                              backgroundColor: theme.colorScheme.primary.withOpacity(0.10),
                              foregroundColor: theme.colorScheme.primary,
                            );
                          }).toList(),
                        ),

                        // Expandable details
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 220),
                          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          firstChild: const SizedBox.shrink(),
                          secondChild: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(),
                                const SizedBox(height: 8),
                                Text(
                                  'Key Features:',
                                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                ...widget.project.highlights.map((h) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 8, right: 8),
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.primary,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Expanded(child: Text(h, style: theme.textTheme.bodySmall)),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ---------- Footer (fixed height) ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isExpanded ? 'Tap to collapse' : 'Tap to expand',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
