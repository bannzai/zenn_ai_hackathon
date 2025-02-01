import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:replai/components/loading/indicator.dart';
import 'package:replai/utils/purchase/purchase.dart';

class PurchaseSetupResolver extends HookConsumerWidget {
  final String userID;
  final Widget Function(BuildContext) builder;

  const PurchaseSetupResolver({
    super.key,
    required this.userID,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDone = useState(false);
    useEffect(() {
      void f() async {
        await initializePurchase(userID);
        isDone.value = true;
      }

      f();
      return null;
    }, []);

    if (!isDone.value) {
      return const IndicatorPage();
    }
    return builder(context);
  }
}
