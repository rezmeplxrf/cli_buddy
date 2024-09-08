import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/scr/constant/global.dart';
import 'package:frontend/scr/model/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket.freezed.dart';
part 'websocket.g.dart';

@riverpod
class WebSocketRespository extends _$WebSocketRespository {
  late final WebSocketChannel? socket;
  StringBuffer msg = StringBuffer();
  @override
  Stream<WebSocketState> build() async* {
    ref.onDispose(() async {
      await disconnect();
    });
    yield state.value ??
        const WebSocketState(
          connectionState: SocketState.disconnected,
        );
    await connect();
  }

  Future<void> connect() async {
    final currentState = state.value;
    if (currentState?.connectionState == SocketState.connected) return;
    state = const AsyncLoading();
    final wsuri = Uri.parse(wsUrl);
    socket = WebSocketChannel.connect(wsuri);
    await socket?.ready;
    state = const AsyncData(WebSocketState(
      connectionState: SocketState.connected,
    ));

    socket?.stream.listen(
      (message) {
        try {
          final msgChunk = MessageChunk.fromJson(
              jsonDecode(message as String) as Map<String, dynamic>);
          if (currentState != null) {
            state = AsyncData(currentState.copyWith(
              chunk: msgChunk,
            ));
            // Handle  MessageChunk.ChunkType and usage
          }
        } catch (e, st) {
          state = AsyncError(e, st);
        }
      },
      onDone: () {
        state = const AsyncData(WebSocketState(
          connectionState: SocketState.disconnected,
        ));
      },
      onError: (Object e, StackTrace st) {
        state = AsyncError(e, st);
      },
    );
  }

  Future<void> disconnect() async {
    if (socket != null) {
      await socket?.sink.close(status.goingAway);
      socket = null;
      state = const AsyncData(WebSocketState(
        connectionState: SocketState.disconnected,
      ));
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
}

enum SocketState { connected, disconnected }

@freezed
class WebSocketState with _$WebSocketState {
  const factory WebSocketState({
    required SocketState connectionState,
    MessageChunk? chunk,
  }) = _WebSocketState;
}
