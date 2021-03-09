import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final RegExp? filter;
  final TextStyle? highlightStyle;

  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;

  HighlightedText({
    Key? key,
    required this.text,
    this.filter,
    this.highlightStyle,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
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
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
    );
  }
}
