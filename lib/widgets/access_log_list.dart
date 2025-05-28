import 'package:flutter/material.dart';

class AccessLogList extends StatelessWidget {
  final List<Map<String, String>> logs;
  final double width;

  const AccessLogList({required this.logs, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = width > 600;
    final items = logs.map((log) => Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.history, color: Colors.teal),
        title: Text('${log['date']} о ${log['time']}'),
      ),
    ),);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Журнал спроб доступу',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          if (isWide) GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 4,
            children: items.toList(),
          ) else ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: items.toList(),
          ),
        ],
      ),
    );
  }
}
