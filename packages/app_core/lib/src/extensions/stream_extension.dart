import 'package:stream_transform/stream_transform.dart';

extension ConditionalDebounce<T> on Stream<T> {
  Stream<T> debounceIf(
    Duration duration,
    bool Function(T) condition,
  ) {
    final debouncedStream = where(condition).debounce(duration);
    final nonDebouncedStream = where((event) => !condition(event));

    return debouncedStream.merge(nonDebouncedStream);
  }
}
