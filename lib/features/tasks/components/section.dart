import 'package:flutter/material.dart';
import 'package:todomaker/components/loading/bot.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/components/todo/list.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/features/task/page.dart';
import 'package:todomaker/style/color.dart';

class TasksPageSection extends StatelessWidget {
  final Task task;
  const TasksPageSection({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final task = this.task;
    final primaryColor = Theme.of(context).colorScheme.primary;

    final definitionAITextResponse = task.definitionAITextResponse;
    final todosGroundings = task.todosGroundings;

    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 120),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        task.question,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (task is TaskPrepared) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(task: task)));
                          }
                        },
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('詳細を見る', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: TextColor.link)),
                            SizedBox(width: 2),
                            Icon(Icons.chevron_right, color: TextColor.link, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (definitionAITextResponse != null) ...[
                    Text(
                      definitionAITextResponse,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (task is TaskPrepared) ...[
                    const Divider(height: 1, color: Colors.black),
                    const SizedBox(height: 20),
                    TasksTodoList(task: task, limit: 3),
                    const Divider(height: 1, color: Colors.black),
                    const SizedBox(height: 16),
                  ],
                  if (todosGroundings != null) ...[
                    GroundingDataList(groundings: todosGroundings),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (task is TaskPreparing) ...[
          const BotLoading(messages: ['準備中...', 'ちょっと待っててね😘', '手順が多いと数分かかることがあるよ☠️', '丁寧にWebから情報を集めてるよ🦾']),
        ],
      ],
    );
  }
}
