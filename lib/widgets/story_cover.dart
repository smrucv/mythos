import 'package:flutter/material.dart';

import '../models/story.dart';

class StoryCover extends StatelessWidget {
  final StoryMetadata story;
  final double? height;
  final BorderRadius? borderRadius;
  final bool darkenBottom;

  const StoryCover({
    super.key,
    required this.story,
    this.height,
    this.borderRadius,
    this.darkenBottom = false,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(story.coverImage, fit: BoxFit.cover),
              if (darkenBottom)
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xD910101A)],
                      stops: [0.45, 1],
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}
