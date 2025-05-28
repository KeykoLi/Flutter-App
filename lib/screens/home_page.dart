import 'package:flutter/material.dart';
import 'package:lab_2/screens/lock_page.dart';
import 'package:lab_2/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, Object>> locks = [
    {'name': 'Вхідні двері', 'model': 'LockModelX',
      'location': 'Квартира', 'icon': Icons.door_front_door,},
    {'name': 'Гараж', 'model': 'GarageLockPro',
      'location': 'Гараж', 'icon': Icons.garage,},
  ];
  IconData? selectedIcon;

  Widget iconChoice(IconData icon, IconData? selected,
      void Function(IconData) onSelect,) {
    final selectedFlag = icon == selected;
    return GestureDetector(
      onTap: () {
        onSelect(icon);
        setState(() {});
      },
      child: CircleAvatar(
        backgroundColor: selectedFlag ? Colors.teal : Colors.grey[300],
        child: Icon(icon, color: selectedFlag ? Colors.white : Colors.black),
      ),
    );
  }

  Future<void> _addLock({required String model,
    required String location, required IconData icon,}) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    Navigator.of(context).pop(); // loading
    setState(() {
      locks.add({'name': model, 'model': model,
        'location': location, 'icon': icon,});
    });
    Navigator.of(context).pop(); // dialog
  }

  void _showAddLockDialog() {
    final modelCtrl = TextEditingController();
    final locCtrl = TextEditingController();
    selectedIcon = null;

    showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          void onIconSelected(IconData icon) {
            selectedIcon = icon;
            setDialogState(() {});
          }

          return AlertDialog(
            title: const Text('Додати замок'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: modelCtrl, decoration:
                const InputDecoration(labelText: 'Модель замка'),),
                TextField(controller: locCtrl, decoration:
                const InputDecoration(labelText: 'Розташування'),),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconChoice(Icons.door_front_door, selectedIcon,
                        onIconSelected,),
                    iconChoice(Icons.garage, selectedIcon, onIconSelected),
                    iconChoice(Icons.gite, selectedIcon, onIconSelected),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Відміна'),),
              ElevatedButton(
                onPressed: () {
                  final model = modelCtrl.text;
                  final loc = locCtrl.text;
                  final icon = selectedIcon ?? Icons.lock;
                  if (model.isNotEmpty && loc.isNotEmpty) {
                    _addLock(model: model, location: loc, icon: icon);
                  }
                },
                child: const Text("Під'єднати"),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Замки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push<void>(
              context,
              MaterialPageRoute<void>(builder: (_) => const ProfilePage()),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: locks.length,
        itemBuilder: (_, i) {
          final lock = locks[i];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),),
            child: ListTile(
              leading: Icon(lock['icon'] as IconData, color: Colors.teal),
              title: Text(lock['name'] as String),
              subtitle: Text(lock['location'] as String),
              onTap: () => Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => LockPage(lockName: lock['name'] as String),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLockDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
