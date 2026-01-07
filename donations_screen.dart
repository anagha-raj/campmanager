import 'package:flutter/material.dart';

class DonationsScreen extends StatelessWidget {
  const DonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donations Received"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          donationCard(
            context,
            donor: "Anil Kumar",
            item: "Rice",
            promisedQty: "100 kg",
            status: "Pending",
          ),
          donationCard(
            context,
            donor: "Sneha S",
            item: "Water Bottles",
            promisedQty: "50",
            status: "Received",
          ),
        ],
      ),
    );
  }

  Widget donationCard(
      BuildContext context, {
        required String donor,
        required String item,
        required String promisedQty,
        required String status,
      }) {
    final bool isPending = status == "Pending";

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              donor,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text("Item: $item"),
            Text("Promised Quantity: $promisedQty"),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(status),
                  backgroundColor:
                  isPending ? Colors.orange.shade100 : Colors.green.shade100,
                  labelStyle: TextStyle(
                    color: isPending ? Colors.orange : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (isPending)
                  ElevatedButton(
                    onPressed: () {
                      showConfirmDialog(context, item);
                    },
                    child: const Text("Confirm Received"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmDialog(BuildContext context, String itemName) {
    final TextEditingController receivedQtyController =
    TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Confirm $itemName Received"),
        content: TextField(
          controller: receivedQtyController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Received Quantity",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Donation confirmed & inventory updated"),
                ),
              );
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
