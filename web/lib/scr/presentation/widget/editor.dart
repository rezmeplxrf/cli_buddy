import 'dart:async';

import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/data/open_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Editor extends HookConsumerWidget {
  const Editor({
    required this.textController,
    required this.debounceTime,
    this.onEnter,
    super.key,
  });

  final TextEditingController textController;
  final int debounceTime;
  final VoidCallback? onEnter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Timer? debounceTimer;
    var previousText = '';
    var isMouseDragging = false;
    Future<void> getSuggestion(String? currentText) async {
      final config = await ref.read(autoCompleteControllerProvider.future);
      if (config == null || config.enabled == false) {
        return;
      }

      if (currentText == null ||
          currentText.trim().isEmpty ||
          isMouseDragging) {
        return;
      }

      final currentPosition = textController.selection.base.offset;
      if (currentPosition < 0 ||
          (debounceTimer != null && debounceTimer!.isActive) ||
          previousText == currentText) {
        return;
      }

      final textBeforeCursor = currentText.substring(0, currentPosition);
      final textAfterCursor = currentText.substring(currentPosition);
      previousText = textBeforeCursor;

      final rawSuggestion = await ref.read(
          openRouterAutoCompleteProvider(context: textBeforeCursor).future);
      if (rawSuggestion == null) return;
      final suggestion = rawSuggestion.result;
      if (suggestion == null || suggestion.trim().isEmpty) return;

      final newText = textBeforeCursor +
          suggestion +
          currentText.substring(currentPosition);
      final newCursorPosition = currentPosition + suggestion.length;

      final baseOffset = textBeforeCursor.length;
      final updatedText = newText + textAfterCursor;
      textController
        ..text = updatedText
        ..selection = TextSelection(
          baseOffset: baseOffset,
          extentOffset: newCursorPosition,
          isDirectional: true,
        );
    }

    final focusNode = useFocusNode(onKeyEvent: (node, event) {
      if (event.logicalKey.keyLabel == 'Enter' &&
          !HardwareKeyboard.instance.isShiftPressed &&
          onEnter != null) {
        if (event is KeyDownEvent) {
          onEnter?.call();
        }
        return KeyEventResult.handled;
      } else if (event.logicalKey.keyLabel == 'Tab') {
        textController.text += '';
        debounceTimer?.cancel();
        debounceTimer = null;
        return KeyEventResult.handled;
      } else if
          // when backspacing
          (event.logicalKey.keyLabel == 'Backspace') {
        debounceTimer?.cancel();
        debounceTimer = null;
        return KeyEventResult.ignored;
      } else {
        return KeyEventResult.ignored;
      }
    });
    final textStyle =
        Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.8;
    int calculateMaxLines(String text) {
      final span = TextSpan(text: text, style: textStyle);
      final tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: MediaQuery.of(context).size.width);

      final lineHeight = tp.preferredLineHeight;
      final maxLines = (maxHeight / lineHeight).floor();
      return maxLines;
    }

    return GestureDetector(
      onPanStart: (_) {
        isMouseDragging = true;
        debounceTimer?.cancel();
        debounceTimer = null;
      },
      onPanEnd: (_) {
        isMouseDragging = false;
      },
      onTapDown: (_) {
        debounceTimer?.cancel();
        debounceTimer = null;
      },
      child: SingleChildScrollView(
        child: TextField(
          decoration: const InputDecoration(
              border: InputBorder.none,
              filled: false,
              contentPadding: EdgeInsets.all(10)),
          style: textStyle,
          controller: textController,
          focusNode: focusNode,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: calculateMaxLines(textController.text),
          onChanged: (input) {
            debounceTimer?.cancel();
            debounceTimer = Timer(Duration(milliseconds: debounceTime), () {
              debounceTimer = null;
              getSuggestion(input);
            });
          },
          onSubmitted: (value) {
            Global.talker.debug('onSubmitted: $value');
          },
          cursorColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
