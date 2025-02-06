import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/utils/functions/firebase_functions.dart';

class QuestionFormSheet extends HookWidget {
  const QuestionFormSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final question = useState('');
    final focusNode = useFocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });

    return DraggableScrollableSheet(
      maxChildSize: 1,
      initialChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 40, left: 16, right: 16),
                  child: TextFormField(
                    focusNode: focusNode,
                    initialValue: question.value,
                    minLines: 1,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      hintText: '例)確定申告の方法,結婚の手続き',
                      labelText: '手順がわからないものをご記入ください',
                    ),
                    onChanged: (value) {
                      question.value = value;
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: TextButton(
                  onPressed: () async {
                    if (question.value.isEmpty) {
                      return;
                    }

                    try {
                      await functions.taskCreate(question: question.value);
                      if (context.mounted) {
                        Navigator.of(context).pop(question.value);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        showErrorAlert(context, e);
                      }
                    }
                  },
                  child: const Text('🤖に聞く'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> showQuestionFormSheet(
  BuildContext context,
) async {
  return await showModalBottomSheet<void>(
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) => const QuestionFormSheet(),
  );
}
