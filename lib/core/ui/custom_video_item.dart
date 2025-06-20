import 'package:flutter/material.dart';

/// A custom video item widget that displays a video preview with title and description.
///
/// This widget is designed to be used in video lists or grids, providing a consistent
/// visual style with a curved bottom-left corner and play button indicator.
class CustomVideoItem extends StatelessWidget {
  /// Creates a custom video item widget.
  const CustomVideoItem({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.nextColor,
    required this.onTap,
  });

  /// The title of the video item.
  final String title;

  /// The description text displayed above the title.
  final String description;

  /// The background color of the main container.
  final Color color;

  /// The background color of the outer container.
  final Color nextColor;

  /// Callback function when the item is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: nextColor,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(80.0),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(32, 40, 32, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Tap to Play',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
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
