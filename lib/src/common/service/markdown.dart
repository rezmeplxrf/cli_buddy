import 'package:barbecue/barbecue.dart';
import 'package:mason_logger/mason_logger.dart';

final markdownStyle = Markdown({
  MarkdownPlaceholder.enclosed(
      '**', (text, match) => styleBold.wrap(text) ?? text),
  MarkdownPlaceholder.enclosed(
      '*', (text, match) => styleItalic.wrap(text) ?? text),
  MarkdownPlaceholder.regexp(
    r'```(?:\w+)?\s*([\s\S]*?)```',
    (text, match) => codeblock(text),
  ),
  MarkdownPlaceholder.enclosed(
    '```',
    (text, match) => codeblock(text),
  ),
  MarkdownPlaceholder.enclosed('`', (text, match) => blue.wrap(text) ?? text),
  MarkdownPlaceholder.string(
      '###', (text, match) => lightGreen.wrap(text) ?? text),
  MarkdownPlaceholder.string(
      '##', (text, match) => lightGreen.wrap(text) ?? text),
  MarkdownPlaceholder.string(
      '#', (text, match) => lightMagenta.wrap(text) ?? text)
});

String codeblock(String text) {
  final table = Table(
    tableStyle: const TableStyle(
      border: true,
    ),
    body: TableSection(
      cellStyle: const CellStyle(
          paddingRight: 1, paddingLeft: 1, alignment: TextAlignment.MiddleLeft),
      rows: [
        Row(cells: [Cell(text)]),
      ],
    ),
  ).render();
  return '${lightBlue.wrap(table)}';
}

final markdownPlain = Markdown({
  MarkdownPlaceholder.enclosed('**', (text, match) => text),
  MarkdownPlaceholder.enclosed('*', (text, match) => text),
  MarkdownPlaceholder.regexp(
    r'```(?:\w+)?\s*([\s\S]*?)```',
    (text, match) => text,
  ),
  MarkdownPlaceholder.enclosed('```', (text, match) => text),
  MarkdownPlaceholder.enclosed('`', (text, match) => text),
  MarkdownPlaceholder.string('###', (text, match) => text),
  MarkdownPlaceholder.string('##', (text, match) => text),
  MarkdownPlaceholder.string('#', (text, match) => text)
});

class Markdown {
  Markdown(this.placeholders);

  final Set<MarkdownPlaceholder> placeholders;

  String apply(String input) {
    final modifiedInput = placeholders.fold(
        input, (prev, placeholder) => placeholder.apply(prev));
    return unescape(modifiedInput);
  }

  String escape(String input) {
    final escapedBackslashes = input.replaceAll(r'\', r'\\');
    return placeholders.fold(escapedBackslashes,
        (prev, placeholder) => placeholder.pattern.escape(prev));
  }

  String unescape(String input) {
    final unescapedPlaceholders = placeholders.fold(
        input, (prev, placeholder) => placeholder.pattern.unescape(prev));
    return unescapedPlaceholders.replaceAll(r'\\', r'\');
  }
}

class MarkdownNode {
  MarkdownNode(
    this.placeholder, {
    required this.input,
    required this.start,
    required this.end,
    required this.level,
  });

  final MarkdownPlaceholder placeholder;
  final MarkdownToken start;
  final MarkdownToken end;
  final String input;
  final int level;
  String? _cachedApply;

  String get text => placeholder.pattern.singleToken
      ? (start.match.groupCount > 0 ? start.match.group(1) ?? '' : '')
      : input.substring(start.end, end.start);

  String get startText => start.match.group(0)!;
  String get endText => end.match.group(0)!;

  Map<String, String> get tagProperties =>
      MarkdownPattern.getPropertiesOfTag(startText);

  String apply() {
    if (_cachedApply != null) return _cachedApply!;
    _cachedApply = input.replaceRange(
      start.start,
      end.end,
      placeholder.replace(
          placeholder.apply(
            text,
            level: level,
          ),
          this),
    );
    return _cachedApply!;
  }

  int translate(int index) => apply().length - input.length + index;

  MarkdownNode clone({
    MarkdownPlaceholder? placeholder,
    MarkdownToken? start,
    MarkdownToken? end,
    String? input,
    int? level,
    bool? strict,
  }) =>
      MarkdownNode(
        placeholder ?? this.placeholder,
        input: input ?? this.input,
        start: start ?? this.start,
        end: end ?? this.end,
        level: level ?? this.level,
      );

  static int endOfAll(List<MarkdownNode> nodes, {bool translated = false}) {
    var index = 0;
    for (final node in nodes) {
      index += translated ? node.translate(node.end.end) : node.end.end;
    }
    return index;
  }
}

class MarkdownPattern {
  MarkdownPattern(this.start, [RegExp? end]) : end = end ?? RegExp('');

  factory MarkdownPattern.regexp(String start, [String? end]) =>
      MarkdownPattern(RegExp(start), end == null ? null : RegExp(end));

  factory MarkdownPattern.string(String start, [String? end]) =>
      MarkdownPattern.regexp(
          RegExp.escape(start), end == null ? null : RegExp.escape(end));

  factory MarkdownPattern.enclosed(String start, [String? end]) =>
      MarkdownPattern.string(start, end ?? start);

  factory MarkdownPattern.symmetrical(String start,
      {bool nested = true, bool sticky = false}) {
    var end = start;
    if (!nested || sticky) {
      start = assistUniqueCharacter(start);
      end = assistUniqueCharacter(end, true);
    } else {
      start = RegExp.escape(start);
      end = RegExp.escape(end);
    }
    if (sticky) {
      start = '$start(?=\\S)';
      end = '(?<=\\S)$end';
    }
    return MarkdownPattern.regexp(start, end);
  }

  factory MarkdownPattern.tag(String start,
      [String? end, Set<String> properties = const {}]) {
    end ??= RegExp(r'[\w-.:#]+').firstMatch(start)?.group(0) ?? start;
    return MarkdownPattern.regexp(
      '<$start${properties.isNotEmpty ? _getPropertiesPattern(properties) : ''}>',
      '<\\/$end>',
    );
  }

  final RegExp start;
  final RegExp end;

  RegExp get startEscaped => escaped(start);
  RegExp get endEscaped => escaped(end);

  bool get uniqueCharater => isUniqueCharater(start.pattern);
  bool get symmetrical => start.pattern == end.pattern;
  bool get singleToken => end.pattern.isEmpty;

  int? nextLevel(String input, [int level = 0]) {
    final start = startEscaped.firstMatch(input);
    final end = endEscaped.firstMatch(input);

    if (symmetrical) {
      if (end == null) return null;
      if (level == 0) return level + 1;
      if (end.start == 0) return level;
      return level - 1;
    }

    if (start == null && end == null) return null;
    if (start == null) return level - 1;
    if (end == null) return level + 1;
    if (start.start < end.start) return level + 1;
    return level - 1;
  }

  MarkdownMatch? findEnd(String input,
      {int level = 1, int offset = 0, bool isIncreasing = true}) {
    final next = nextLevel(input, level);
    if (next == null) return null;
    if (next < level || (next == level && !isIncreasing)) {
      final end = endEscaped.firstMatch(input);
      if (end == null) return null;
      return MarkdownMatch(end, offset);
    }

    final start = startEscaped.firstMatch(input)!;
    final nextEnd = findEnd(input.substring(start.end),
        level: level + 1, offset: offset + start.end);
    if (nextEnd == null) return null;

    final lastEnd = findEnd(input.substring(nextEnd.end - offset),
        level: level, offset: nextEnd.end, isIncreasing: false);
    if (lastEnd == null) return null;

    return lastEnd;
  }

  static String escapePattern = r'(?<=(?<!\\)(?:\\\\)*)';
  static String unescapePattern = escapePattern + r'\\';

  static RegExp escaped(Pattern pattern) {
    if (pattern is RegExp) return RegExp(escapePattern + pattern.pattern);
    return RegExp(escapePattern + pattern.toString());
  }

  String escape(String input) => input.replaceAllMapped(
      RegExp(start.pattern), (match) => '\\${match.group(0)}');

  String unescape(String input) => input.replaceAll(
      RegExp('$unescapePattern(?=${start.pattern}|${end.pattern})'), '');

  static bool isUniqueCharater(String input) =>
      input.split('').toSet().length == 1;

  static String assistUniqueCharacter(String input, [bool end = false]) {
    return !end
        ? '${RegExp.escape(input)}(?!${RegExp.escape(input[0])})'
        : '(?<!${RegExp.escape(input[0])})${RegExp.escape(input)}';
  }

  static Map<String, String> getPropertiesOfTag(String input) {
    final properties = <String, String>{};
    final match = _tagWithPropertiesPattern.allMatches(input);

    for (final property in match) {
      final propertiesMatch =
          _tagPropertyPattern.allMatches(property.group(1)!);
      for (final property in propertiesMatch) {
        properties[property.group(1)!] = property.group(2) ?? '';
      }
    }

    return properties;
  }

  static String _getPropertyPattern([String? name, bool escape = true]) =>
      '(${name != null && name.isNotEmpty && name != '*' ? (escape ? RegExp.escape(name) : name) : r'[\w-.:#]+'})(?:=["\']([^"\']*?)["\'])?';

  static String _getPropertiesPattern([Set<String> properties = const {}]) =>
      '(?:\\s+${_getPropertyPattern(properties.join('|'), false)})*';

  static final _tagPropertyPattern = RegExp(_getPropertyPattern());
  static final _tagWithPropertiesPattern =
      RegExp('<.+?(${_getPropertiesPattern()})>');
}

class MarkdownPlaceholder {
  MarkdownPlaceholder(this.pattern, this.replace);

  factory MarkdownPlaceholder.string(String start, MarkdownReplace replace,
      {String? end}) {
    return MarkdownPlaceholder(MarkdownPattern.string(start, end), replace);
  }

  factory MarkdownPlaceholder.enclosed(String start, MarkdownReplace replace,
      {String? end}) {
    return MarkdownPlaceholder(MarkdownPattern.enclosed(start, end), replace);
  }

  factory MarkdownPlaceholder.regexp(String start, MarkdownReplace replace,
      {String? end}) {
    return MarkdownPlaceholder(MarkdownPattern.regexp(start, end), replace);
  }

  factory MarkdownPlaceholder.tag(String start, MarkdownReplace replace,
      {String? end, Set<String> properties = const {}}) {
    return MarkdownPlaceholder(
        MarkdownPattern.tag(start, end, properties), replace);
  }

  factory MarkdownPlaceholder.symmetrical(String start, MarkdownReplace replace,
      {bool nested = true, bool sticky = false}) {
    return MarkdownPlaceholder(
        MarkdownPattern.symmetrical(start, nested: nested, sticky: sticky),
        replace);
  }

  final MarkdownPattern pattern;
  final MarkdownReplace replace;

  String apply(String input, {int level = 0}) {
    final nodes = _parseAll(
      input,
      level: level,
    );
    if (nodes.isEmpty) return input;

    return _applyAll(nodes);
  }

  String _applyAll(List<MarkdownNode> nodes) {
    final buffer = StringBuffer();
    for (final node in nodes) {
      final isLast = node == nodes.last;
      final appliedString = node.apply();
      final substringEnd =
          isLast ? appliedString.length : node.translate(node.end.end);
      buffer.write(appliedString.substring(0, substringEnd));
    }
    return buffer.toString();
  }

  MarkdownNode? _parse(String input, {int level = 0}) {
    final start = pattern.startEscaped.firstMatch(input);
    if (start == null) return null;

    final end = pattern.findEnd(input.substring(start.end), level: level + 1);
    if (end != null) {
      return MarkdownNode(
        this,
        input: input,
        start: MarkdownToken(start, start.start, start.end),
        end: MarkdownToken(end.token, start.end + end.offset + end.token.start,
            start.end + end.offset + end.token.end),
        level: level,
      );
    }

    final node = _parse(
      input.substring(start.end),
      level: level,
    );
    if (node == null) return null;

    return node.clone(
      input: input,
      start: MarkdownToken(node.start.match, node.start.start + start.end,
          node.start.end + start.end),
      end: MarkdownToken(
          node.end.match, node.end.start + start.end, node.end.end + start.end),
    );
  }

  List<MarkdownNode> _parseAll(String input, {int level = 0}) {
    final original = input;
    final nested = <MarkdownNode>[];
    var remainingInput = input;

    while (true) {
      final MarkdownNode? node;
      try {
        node = _parse(
          remainingInput,
          level: level,
        );
      } catch (error) {
        throw Exception('Invalid placeholder: $original - error: $error');
      }
      if (node == null) break;

      nested.add(node);
      remainingInput = remainingInput.substring(node.end.end);
    }
    return nested;
  }
}

typedef MarkdownReplace = String Function(String text, MarkdownNode match);

class MarkdownToken {
  MarkdownToken(this.match, this.start, this.end);
  final RegExpMatch match;
  final int start;
  final int end;
}

class MarkdownMatch {
  MarkdownMatch(this.token, this.offset);
  final RegExpMatch token;
  final int offset;

  int get start => token.start + offset;
  int get end => token.end + offset;
}
