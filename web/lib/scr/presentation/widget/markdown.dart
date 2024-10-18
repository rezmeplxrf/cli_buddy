import 'package:buddy_chat/scr/constant/helper.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BuildMarkdownWidget extends StatelessWidget {
  const BuildMarkdownWidget({
    required this.message,
    super.key,
  });

  final Message message;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final config =
        isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;
    _CodeWrapperWidget codeWrapper(
        Widget child, String text, String? language) {
      return _CodeWrapperWidget(child, text, language, isDark);
    }

    return MarkdownWidget(
      
      data: message.content,
      shrinkWrap: true,
      config: config.copy(configs: [
        if (isDark)
          PreConfig.darkConfig.copy(
            wrapper: codeWrapper,
          )
        else
          const PreConfig().copy(
            wrapper: codeWrapper,
          ),
        const LinkConfig(
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          onTap: launchUrlString,
        )
      ]),
    );
  }
}

class _CodeWrapperWidget extends StatelessWidget {
  const _CodeWrapperWidget(this.child, this.text, this.language, this.isDark);
  final Widget child;
  final String text;
  final String? language;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
      child: Stack(
        children: [child, _CodeBlockButtons(language: language, text: text)],
      ),
    );
  }
}

class _CodeBlockButtons extends HookWidget {
  const _CodeBlockButtons({
    required this.language,
    required this.text,
  });

  final String? language;
  final String text;

  @override
  Widget build(BuildContext context) {
    final hasCopied = useState<bool>(false);
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (language != null && language!.isNotEmpty)
              SelectionContainer.disabled(
                  child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                    language != null
                        ? Helper.capitalizeFirstLetter(language!)
                        : '',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
              )),
            IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              icon: !hasCopied.value
                  ? const Icon(Icons.copy_rounded)
                  : const Icon(Icons.check),
              onPressed: () async {
                if (hasCopied.value) return;
                hasCopied.value = true;
                await Clipboard.setData(ClipboardData(text: text));
                Future.delayed(const Duration(seconds: 2), () {
                  hasCopied.value = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
