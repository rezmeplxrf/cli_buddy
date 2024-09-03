// import 'package:ansix/src/ansix.dart';
// import 'package:ansix/src/core/extensions/extensions.dart';
// import 'package:ansix/src/theme/theme.dart';
// import 'package:ansix/src/widgets/grid/grid.dart';
// import 'package:marked/marked.dart';

// final markdown = Markdown({
//   MarkdownPlaceholder.enclosed(
//       strict: true,
//       '```',
//       (text, match) => text.withBackgroundColor(AnsiColor.lightGreen)),
//   MarkdownPlaceholder.enclosed('**', (text, match) => text.bold()),
//   MarkdownPlaceholder.enclosed('*', (text, match) => text.italic()),
//   MarkdownPlaceholder.enclosed('__', (text, match) => text.underline()),
//   MarkdownPlaceholder.enclosed('~~', (text, match) => text.strikethrough()),
//   MarkdownPlaceholder.enclosed(
//       '`', (text, match) => text.withForegroundColor(AnsiColor.yellow)),
//   MarkdownPlaceholder.string(
//       '>', (text, match) => text.withBackgroundColor(AnsiColor.blue)),
//   MarkdownPlaceholder.string(
//       '## ', (text, match) => text.withBackgroundColor(AnsiColor.green).bold()),
//   MarkdownPlaceholder.string(
//       '# ', (text, match) => text.withBackgroundColor(AnsiColor.red).bold()),
// });

// void main() {
//   AnsiX.ensureSupportsAnsi();


//   final messages = <String>[
//     // Markdown examples
//     '**Bold Text**',
//     '*Italic Text*',
//     '__Underline Text__',
//     '~~Strikethrough Text~~',
//     '`Inline Code`',
//     '```Block Code```',
//     '> Blockquote',
//     '# Heading 1',
//     '## Heading 2',
//     '### Heading 3',
//     '#### Heading 4',
//     '##### Heading 5',
//     '###### Heading 6',
//   ];

//   for (final message in messages) {
//    print(markdown.apply(message));
//   }

//   print(
//     AnsiGrid.list(
//       <Object?>[
//         true,
//         242,
//         3.0,
//         'lalala',
//         'this is a line',
//       ],
//       theme: const AnsiGridTheme(
//         border: AnsiBorder(
//           style: AnsiBorderStyle.rounded,
//           color: AnsiColor.fuchsia,
//         ),
//         // defaultAlignment: AnsiTextAlignment.center,
//       ),
//     ),
//   );
// }
