import 'package:flutter/material.dart';

class LockStatusCard extends StatelessWidget {
  final bool isLocked;
  final String code;
  final double width;
  final VoidCallback onToggle;
  final void Function(String) onChangeCode;

  const LockStatusCard({
    required this.isLocked,
    required this.code,
    required this.width,
    required this.onToggle,
    required this.onChangeCode,
    super.key,
  });

  void _showChangeCodeDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog<void>( // Явно вказуємо тип void для showDialog
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Змінити код замка'),
        content: TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 10,
          decoration: const InputDecoration(
            labelText: 'Новий код',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Скасувати'),
          ),
          ElevatedButton(
            onPressed: () {
              final newCode = controller.text.trim();
              if (newCode.isNotEmpty) {
                onChangeCode(newCode);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Код змінено: $newCode')),
                );
              }
            },
            child: const Text('Зберегти'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final icon = isLocked ? Icons.lock : Icons.lock_open;
    final text = isLocked ? 'Замок ЗАЧИНЕНО' : 'Замок ВІДЧИНЕНО';
    final color = isLocked ? Colors.red : Colors.green;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: 16),
      color: color.shade100,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(icon, size: width * 0.15, color: color),
            const SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onToggle,
              icon: Icon(isLocked ? Icons.lock_open : Icons.lock),
              label: Text(isLocked ? 'Відчинити' : 'Зачинити'),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: width > 500 ? 32 : 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text('Код: $code', style: const TextStyle(color: Colors.black54)),
            TextButton.icon(
              onPressed: () => _showChangeCodeDialog(context),
              icon: const Icon(Icons.edit, color: Colors.teal),
              label: const Text('Змінити код'),
            ),
          ],
        ),
      ),
    );
  }
}
