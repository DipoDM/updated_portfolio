import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/services/resume_models.dart';
import '../../core/widgets/chip.dart';
import '../../core/widgets/responsive.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with TickerProviderStateMixin {
  bool _isExpanded = false;
  final ScrollController _bodyCtrl = ScrollController();
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _sizeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _sizeAnimation = CurvedAnimation(
      parent: _sizeController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _bodyCtrl.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    // Responsive padding and spacing
    final cardPadding = isMobile
        ? 12.0
        : isTablet
            ? 16.0
            : 20.0;
    final verticalSpacing = isMobile ? 8.0 : 12.0;
    final borderRadius = isMobile ? 12.0 : 16.0;

    return AnimatedBuilder(
      animation: _sizeAnimation,
      builder: (context, child) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _sizeController.forward();
                } else {
                  _sizeController.reverse();
                }
              });
              HapticFeedback.lightImpact();
            },
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with responsive typography
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.project.name,
                                style: (isMobile ? theme.textTheme.titleMedium : theme.textTheme.titleLarge)?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (widget.project.isPrivate) ...[
                              SizedBox(width: isMobile ? 8 : 12),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 6 : 8,
                                  vertical: isMobile ? 2 : 4,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                                  border: Border.all(
                                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  'Private',
                                  style: (isMobile ? theme.textTheme.labelSmall : theme.textTheme.bodySmall)?.copyWith(
                                    color: theme.colorScheme.outline,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      IconButton(
                        iconSize: isMobile ? 20.0 : 24.0,
                        icon: Icon(
                          Icons.open_in_new,
                          color: theme.colorScheme.primary,
                        ),
                        tooltip: 'Open Project',
                        onPressed: () async {
                          final url = Uri.parse(widget.project.url);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Could not launch ${widget.project.url}')),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: verticalSpacing),

                  // Content that adapts to size
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Description (responsive lines)
                      Text(
                        widget.project.description,
                        style: isMobile ? theme.textTheme.bodySmall : theme.textTheme.bodyMedium,
                        maxLines: _isExpanded ? null : (isMobile ? 2 : 3),
                        overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      ),
                      SizedBox(height: verticalSpacing),

                      // Tech chips with responsive sizing
                      Wrap(
                        spacing: isMobile ? 6 : 8,
                        runSpacing: isMobile ? 4 : 6,
                        children: widget.project.tech.map((tech) {
                          return AppChip(
                            label: tech,
                            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.10),
                            foregroundColor: theme.colorScheme.primary,
                          );
                        }).toList(),
                      ),

                      // Expandable details with smooth animation
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: _isExpanded
                            ? Padding(
                                padding: EdgeInsets.only(top: verticalSpacing * 1.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(
                                      color: theme.colorScheme.outline.withValues(alpha: 0.2),
                                    ),
                                    SizedBox(height: verticalSpacing),
                                    Text(
                                      'Key Features:',
                                      style: (isMobile ? theme.textTheme.titleSmall : theme.textTheme.titleMedium)?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    SizedBox(height: verticalSpacing),
                                    ...widget.project.highlights.map((highlight) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: verticalSpacing * 0.5),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: isMobile ? 6 : 8, right: 8),
                                              width: isMobile ? 3 : 4,
                                              height: isMobile ? 3 : 4,
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme.primary,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                highlight,
                                                style: isMobile ? theme.textTheme.bodySmall : theme.textTheme.bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      // Footer with responsive spacing
                      SizedBox(height: verticalSpacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isExpanded ? 'Tap to collapse' : 'Tap to expand',
                            style: (isMobile ? theme.textTheme.labelSmall : theme.textTheme.bodySmall)?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Icon(
                            _isExpanded ? Icons.expand_less : Icons.expand_more,
                            size: isMobile ? 18 : 20,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
