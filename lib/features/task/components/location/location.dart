import 'package:flutter/material.dart';
import 'package:todomaker/entity/grounding_data.dart';
import 'package:todomaker/entity/location.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/features/task/components/location/ask.dart';
import 'package:todomaker/features/todo_locations/page.dart';
import 'package:todomaker/style/color.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskLocation extends StatelessWidget {
  final TaskPrepared task;
  final List<Todo> todos;
  const TaskLocation({super.key, required this.task, required this.todos});

  @override
  Widget build(BuildContext context) {
    final locations = task.locations;
    final locationGroundings = task.locationsGroundings;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Builder(builder: (context) {
            if (locations == null) {
              return TaskLocationAskAI(task: task);
            }

            // NOTE: FIXME: loading/bot の表示のために領域確保している
            return Column(
              children: [
                TaskLocationAskAI(task: task),
                const SizedBox(height: 10),
                for (final location in locations) ...[
                  TaskLocationItem(
                    task: task,
                    location: location,
                    locationGroundings: locationGroundings ?? [],
                  ),
                ],
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TodoLocationListLink(todos: todos),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// NOTE: TodoLocationRowと一緒な見た目
class TaskLocationItem extends StatelessWidget {
  final TaskPrepared task;
  final AppLocation location;
  final List<GroundingData> locationGroundings;

  const TaskLocationItem({
    super.key,
    required this.task,
    required this.location,
    required this.locationGroundings,
  });

  @override
  Widget build(BuildContext context) {
    final address = location.address;
    final postalCode = location.postalCode;
    final tel = location.tel;
    final email = location.email;
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final emailIsValid = emailRegex.hasMatch(email ?? '');
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12, color: TextColor.black),
      child: Column(
        children: [
          Row(
            children: [
              const Text('🏠 名称:'),
              Expanded(
                child: GestureDetector(
                  onTap: () => _openMap(nameOrAddress: location.name ?? ''),
                  child: Text(location.name ?? '', style: const TextStyle(color: TextColor.link)),
                ),
              ),
            ],
          ),
          if (address != null) ...[
            Row(
              children: [
                const Text('📝 住所:'),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openMap(nameOrAddress: location.address ?? ''),
                    child: Text(address, style: const TextStyle(color: TextColor.link)),
                  ),
                ),
              ],
            ),
          ],
          if (postalCode != null) ...[
            Row(
              children: [
                const Text('📮 郵便番号:'),
                Text(postalCode),
              ],
            ),
          ],
          if (tel != null) ...[
            Row(
              children: [
                const Text('📞 電話番号:'),
                GestureDetector(
                  onTap: () => _openPhoneApp(tel: tel),
                  child: Text(tel, style: const TextStyle(color: TextColor.link)),
                ),
              ],
            ),
          ],
          if (email != null) ...[
            Row(
              children: [
                const Text('📧 メールアドレス:'),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openMailApp(mailAddress: email),
                    child: Text(email,
                        style: TextStyle(
                          color: emailIsValid ? TextColor.link : TextColor.black,
                        )),
                  ),
                ),
              ],
            ),
          ],
          if (locationGroundings.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (locationGroundings.isNotEmpty) ...[
                      const Text('参考URL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                    for (final grounding in locationGroundings) ...[
                      if (grounding.url != null) ...[
                        Link(
                            uri: Uri.parse(grounding.url!),
                            builder: (BuildContext ctx, FollowLink? openLink) {
                              return GestureDetector(
                                onTap: openLink,
                                child: Text(
                                  grounding.title ?? '',
                                  style: const TextStyle(fontSize: 14, color: TextColor.link),
                                ),
                              );
                            }),
                      ],
                    ],
                  ],
                ),
                const Spacer(),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openMap({required String nameOrAddress}) async {
    // FIXME: xxxlaunchUrl 系統でおそらくencodeされているが、その関係でうまくいかないので旧メソッドを使っている
    final url = 'https://www.google.com/maps/search/?api=1&query=$nameOrAddress';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url, forceSafariVC: false);
    } else {
      final Error error = ArgumentError('Could not launch $url');
      throw error;
    }
  }

  Future<void> _openPhoneApp({required String tel}) async {
    final telValue = tel.replaceAll(' ', '').replaceAll('-', '');
    final Uri uri = Uri(
      scheme: 'tel',
      path: telValue,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final Error error = ArgumentError('Could not launch $uri');
      throw error;
    }
  }

  Future<void> _openMailApp({required String mailAddress}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: mailAddress,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final Error error = ArgumentError('Could not launch $uri');
      throw error;
    }
  }
}

class TodoLocationListLink extends StatelessWidget {
  final List<Todo> todos;
  const TodoLocationListLink({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TodoLocationsPage(todos: todos))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('関連場所一覧 ', style: TextStyle(color: TextColor.secondaryLink)),
          Icon(Icons.chevron_right, color: TextColor.secondaryLink),
        ],
      ),
    );
  }
}
