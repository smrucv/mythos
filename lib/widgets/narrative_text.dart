import 'package:flutter/material.dart';

/// Respeta los marcadores **negrita** y *cursiva* presentes en algunos nodos.
/// No interpreta HTML ni ejecuta contenido externo.
class NarrativeText extends StatelessWidget {
  final String content;

  const NarrativeText(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: 17,
          height: 1.72,
          color: const Color(0xFFF1EDF7),
        );
    final parts = <TextSpan>[];
    final pattern = RegExp(r'\*\*([^*]+)\*\*|\*([^*]+)\*');
    var previous = 0;
    for (final match in pattern.allMatches(content)) {
      if (match.start > previous) {
        parts.add(TextSpan(text: content.substring(previous, match.start)));
      }
      if (match.group(1) != null) {
        parts.add(TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      } else {
        parts.add(TextSpan(
          text: match.group(2),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ));
      }
      previous = match.end;
    }
    if (previous < content.length) {
      parts.add(TextSpan(text: content.substring(previous)));
    }
    return SelectableText.rich(TextSpan(style: style, children: parts));
  }
}
