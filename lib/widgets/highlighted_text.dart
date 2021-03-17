import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final RegExp? filter;
  final TextStyle? highlightStyle;
  final TextStyle? style;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;

  HighlightedText({
    Key? key,
    required this.text,
    this.filter,
    this.highlightStyle,
    this.style,
    this.softWrap,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];

    if (filter == null) {
      spans.add(TextSpan(text: text));
    } else {
      text.splitMapJoin(filter!, onMatch: (match) {
        if (match.group(0)!.isNotEmpty) {
          spans.add(TextSpan(
            text: match.group(0),
            style: highlightStyle,
          ));
        }
        return match.input;
      }, onNonMatch: (str) {
        if (str.isNotEmpty) {
          spans.add(TextSpan(text: str));
        }
        return str;
      });
    }

    return Text.rich(
      TextSpan(
        children: spans,
      ),
      style: style,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
