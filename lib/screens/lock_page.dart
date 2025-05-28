import 'package:flutter/material.dart';
import 'package:lab_2/widgets/access_log_list.dart';
import 'package:lab_2/widgets/lock_status_card.dart';

class LockPage extends StatefulWidget {
  final String lockName;
  const LockPage({required this.lockName, super.key});

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  bool isLocked = true;
  String lockCode = '1234';
  final List<Map<String, String>> accessLog = [
    {'date': '2025-05-25', 'time': '14:30'},
    {'date': '2025-05-24', 'time': '08:12'},
    {'date': '2025-05-23', 'time': '21:45'},
  ];

  void _toggleLock() {
    setState(() {
      isLocked = !isLocked;
      accessLog.insert(0, {
        'date': DateTime.now().toString().substring(0, 10),
        'time': TimeOfDay.now().format(context),
      });
    });
  }

  void _changeCode(String newCode) {
    setState(() => lockCode = newCode);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text(widget.lockName)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LockStatusCard(
              isLocked: isLocked,
              code: lockCode,
              width: width,
              onToggle: _toggleLock,
              onChangeCode: _changeCode,
            ),
            const Divider(thickness: 1.2),
            AccessLogList(logs: accessLog, width: width),
          ],
        ),
      ),
    );
  }
}
