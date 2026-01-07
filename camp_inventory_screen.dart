import 'package:flutter/material.dart';

class CampInventoryScreen extends StatefulWidget {
  const CampInventoryScreen({super.key});

  @override
  State<CampInventoryScreen> createState() => _CampInventoryScreenState();
}

class _CampInventoryScreenState extends State<CampInventoryScreen> {
  final Map<String, String> inventory = {
    "Rice": "120 kg",
    "Water Bottles": "300",
    "Medicines": "50 units",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camp Inventory"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: inventory.keys.map((item) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            margin: const EdgeInsets.only(bottom: 14),
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text(
                item,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    inventory[item]!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      _showEditDialog(item);
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showEditDialog(String itemName) {
    final TextEditingController qtyController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Update $itemName"),
        content: TextField(
          controller: qtyController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: "New Quantity",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (qtyController.text.isNotEmpty) {
                setState(() {
                  inventory[itemName] = qtyController.text;
                });
              }
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Inventory updated successfully"),
                ),
              );
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
