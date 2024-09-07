import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend/scr/component/helper.dart';
import 'package:frontend/scr/model/session.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildMarkDownList extends StatelessWidget {
  const BuildMarkDownList({required this.messages, super.key});
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final config =
        isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final role = message.role.toString().split('.').last;
        final dateTime =
            DateTime.fromMillisecondsSinceEpoch(message.timestamp).toLocal();
        final formattedDate = DateFormat.yMMMd().add_jm().format(dateTime);

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Helper.capitalizeFirstLetter(role)} - $formattedDate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              _BuildMarkdownWidget(
                  message: message, config: config, isDark: isDark),
              const Divider()
            ],
          ),
        );
      },
    );
  }
}

class _BuildMarkdownWidget extends StatelessWidget {
  const _BuildMarkdownWidget({
    required this.message,
    required this.config,
    required this.isDark,
  });

  final Message message;
  final MarkdownConfig config;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    _CodeWrapperWidget codeWrapper(
        Widget child, String text, String? language) {
      return _CodeWrapperWidget(child, text, language, isDark);
    }

    return MarkdownWidget(
      data: message.content,
      shrinkWrap: true,
      config: config.copy(configs: [
        if (isDark)
          PreConfig.darkConfig.copy(wrapper: codeWrapper)
        else
          const PreConfig().copy(wrapper: codeWrapper),
        LinkConfig(
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          onTap: (url) {
            launchUrl(Uri.parse(url));
          },
        )
      ]),
    );
  }
}

class _CodeWrapperWidget extends HookWidget {
  const _CodeWrapperWidget(this.child, this.text, this.language, this.isDark);
  final Widget child;
  final String text;
  final String? language;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final hasCopied = useState<bool>(false);
    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (language != null && language!.isNotEmpty)
                  SelectionContainer.disabled(
                      child: Container(
                    margin: const EdgeInsets.only(right: 2),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            width: 0.5,
                            color: isDark ? Colors.white : Colors.black)),
                    child: Text(language!),
                  )),
                InkWell(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: !hasCopied.value
                        ? const Icon(Icons.copy_rounded)
                        : const Icon(Icons.check),
                  ),
                  onTap: () async {
                    if (hasCopied.value) return;
                    await Clipboard.setData(ClipboardData(text: text));
                    Future.delayed(const Duration(seconds: 2), () {
                      hasCopied.value = false;
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
