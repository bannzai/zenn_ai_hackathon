import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todomaker/components/loading/indicator.dart';

class Loading extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const Loading({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          const Indicator(),
        ],
      ],
    );
  }
}

class LoadingAction<T> extends HookWidget {
  final Future<T> Function() action;
  final Widget Function(Future<T>, bool isLoading) builder;

  const LoadingAction({
    super.key,
    required this.action,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final future = useMemoized(() => action(), []);
    final asyncSnapshot = useFuture(future);

    useEffect(() {
      isLoading.value = asyncSnapshot.connectionState == ConnectionState.waiting;
      return null;
    }, [asyncSnapshot]);

    return Loading(
      isLoading: isLoading.value,
      child: builder(future, isLoading.value),
    );
  }
}
