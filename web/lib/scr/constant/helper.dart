

import 'dart:async';

import 'package:buddy_chat/scr/domain/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Helper {
  static String capitalizeFirstLetter(String string) {
    return string[0].toUpperCase() + string.substring(1);
  }

static String pricingFormat(String? value) {
  if (value == null) {
    return 'N/A';
  }
  return '\$$value';
}


  static Map<String, dynamic> toAPICompatibleJson(Message message) {
    return {
      'role': message.role.name,
      'content': message.content,
    };
  }
}

extension CacheForExtension on AutoDisposeRef<Object?> {
  /// Keeps the provider alive for [duration].
  KeepAliveLink? cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);

    return link;
  }
}
