import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/retry/page.dart';

class RetryButton extends HookConsumerWidget {
  final Object exception;
  final StackTrace? stackTrace;

  const RetryButton({
    super.key,
    required this.exception,
    required this.stackTrace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Retry: $exception');
    debugPrint('StackTrace: $stackTrace');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ElevatedButton(
        onPressed: () {
          Retry.of(context).retry();
        },
        child: const Text('再試行'),
      ),
    );
  }
}
