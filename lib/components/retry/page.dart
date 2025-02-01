import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Retry extends InheritedWidget {
  final VoidCallback retry;

  const Retry({
    super.key,
    required this.retry,
    required super.child,
  });

  static Retry of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<Retry>();
    assert(result != null, 'No Retry found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(Retry oldWidget) {
    return retry != oldWidget.retry;
  }
}

class RetryPage extends HookConsumerWidget {
  final Object exception;

  const RetryPage({
    super.key,
    required this.exception,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Retry: $exception');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              exception.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ElevatedButton(
                onPressed: () {
                  Retry.of(context).retry();
                },
                child: const Text('再試行'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
