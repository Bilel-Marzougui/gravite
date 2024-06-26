import 'dart:developer' as developer;

mixin Logger {
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => developer.log('** $text. isError: [$isError]'));
  }
}