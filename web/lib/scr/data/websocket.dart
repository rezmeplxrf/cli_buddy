import 'dart:convert';

import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/application/session.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket.g.dart';

@Riverpod(keepAlive: true)
class WebSocketRespository extends _$WebSocketRespository {
  WebSocketChannel? socket;

  Message? lastMessage;
  @override
  Future<void> build() async {
    await connect();
  }

  Future<void> connect() async {
    if (socket != null) return;
    state = const AsyncLoading();
    final wsuri = Uri.parse(wsUrl);
    socket = WebSocketChannel.connect(wsuri);
    await socket?.ready;

    socket?.stream.listen(
      (message) {
        try {
          final msgChunk = MessageChunk.fromJson(
              jsonDecode(message as String) as Map<String, dynamic>);

          switch (msgChunk.type) {
            case ChunkType.start:
              lastMessage = Message(
                role: Role.assistant,
                content: 'Thinking...',
                timestamp: DateTime.now().millisecondsSinceEpoch,
              );

              ref
                  .read(currentSessionControllerProvider.notifier)
                  .updateMessage(lastMessage!);
            case ChunkType.chunk:
              if (lastMessage != null) {
                lastMessage = lastMessage!.copyWith(
                  content: msgChunk.content ?? '',
                );
                ref
                    .read(currentSessionControllerProvider.notifier)
                    .updateMessage(lastMessage!);
              }

            case ChunkType.end:
              if (lastMessage != null) {
                lastMessage = lastMessage!.copyWith(
                  usage: msgChunk.usage,
                );
                ref
                    .read(currentSessionControllerProvider.notifier)
                    .updateMessage(lastMessage!, isFinished: true);

                ref.read(isAIRespondingProvider.notifier).set(false);
                lastMessage = null;
              }

            case ChunkType.error:
              final markdownErrorMsg = '''
#### Sorry, something went wrong

**${msgChunk.content}**

Please try again.

If this issue persists:
- Check your credit balance and/or change the model to another one.
- If you were using a free model, please note that free models are heavily rate-limited.

Please refer to this [Documentation](https://openrouter.ai/docs/errors) for more details.
''';

              lastMessage = lastMessage?.copyWith(
                content: markdownErrorMsg,
              );
              ref
                  .read(currentSessionControllerProvider.notifier)
                  .updateMessage(lastMessage!);
              lastMessage = null;
          }
        } catch (e, st) {
          Global.talker.error(e, st);
        }
      },
      onDone: () async {
        await disconnect();
        await connect();
      },
      onError: (Object e, StackTrace st) async {
        await disconnect();
        await connect();
      },
    );
  }

  Future<void> disconnect() async {
    if (socket != null) {
      await socket?.sink.close(status.goingAway);
      socket = null;
    }
  }

  Future<void> sendMessage(ChatSession session) async {
    try {
      if (socket != null) {
        socket?.sink.add(jsonEncode(session));
      } else {
        await connect();
        socket?.sink.add(jsonEncode(session));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancel() async {
    try {
      if (socket != null) {
        socket?.sink.add('Cancel');
      } else {
        await connect();
        socket?.sink.add('Cancel');
      }
    } catch (e) {
      rethrow;
    }
  }
}
