import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class QuestionFormSheet extends HookWidget {
  final String text;
  final FormFieldValidator<String>? validator;

  const QuestionFormSheet({super.key, required this.text, this.validator});

  @override
  Widget build(BuildContext context) {
    final text = useState(this.text);
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
                    initialValue: text.value,
                    validator: validator,
                    minLines: 1,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (value) {
                      text.value = value;
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(text.value);
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

Future<String?> showQuestionFormSheet(BuildContext context, {required String text, FormFieldValidator<String>? validator}) async {
  return await showModalBottomSheet<String?>(
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) => QuestionFormSheet(text: text, validator: validator),
  );
}
