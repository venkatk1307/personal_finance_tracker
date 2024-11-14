import 'package:flutter/material.dart';

// Custom Model Class for Savings
class Saving {
  final String title;
  final IconData icon;
  double amount;

  Saving({required this.title, required this.icon, this.amount = 0.0});
}

class SavingsPage extends StatefulWidget {
  @override
  _SavingsPageState createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  // List of Savings
  final List<Saving> savings = [
    Saving(title: "Emergency Fund", icon: Icons.attach_money),
    Saving(title: "Retirement Fund", icon: Icons.savings),
    Saving(title: "Education Fund", icon: Icons.book),
    Saving(title: "Travel Fund", icon: Icons.airplanemode_active),
    Saving(title: "Investment Fund", icon: Icons.trending_up),
    Saving(title: "Other", icon: Icons.more_horiz),
  ];

  // Method to calculate total savings
  double get totalSavings => savings.fold(0.0, (sum, saving) => sum + saving.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32.0),
          // Total Savings Section
          Column(
            children: [
              Text(
                "Total Savings",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8.0),
              Text(
                "₹${totalSavings.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                "Manage your funds",
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          // Savings Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                children: savings.map((saving) {
                  return _buildSavingsBox(context, saving);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSavingDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Saving Category',
      ),
    );
  }

  // Widget to build a savings box
  Widget _buildSavingsBox(BuildContext context, Saving saving) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _showSavingsDialog(context, saving);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(saving.icon, size: 30.0),
              SizedBox(height: 8.0),
              // Use Expanded and TextOverflow.ellipsis for title
              Expanded(
                child: Text(
                  saving.title,
                  style: TextStyle(fontSize: 14.0),
                  overflow: TextOverflow.ellipsis, // Truncate with ellipsis
                  maxLines: 1, // Limit to one line
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                "₹${saving.amount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 14.0, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog to edit amount for a saving
  void _showSavingsDialog(BuildContext context, Saving saving) {
    final TextEditingController amountController = TextEditingController();

    amountController.text = saving.amount.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Amount for ${saving.title}"),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: "Amount"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final double? amount = double.tryParse(amountController.text);
                if (amount != null && amount >= 0) {
                  setState(() {
                    saving.amount = amount;
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Dialog to add a new saving category
  void _showAddSavingDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    IconData? selectedIcon;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Saving Category"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Saving Category Name"),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<IconData>(
                decoration: InputDecoration(labelText: "Choose Icon"),
                items: [
                  {"name": "Emergency Fund", "icon": Icons.attach_money},
                  {"name": "Retirement Fund", "icon": Icons.savings},
                  {"name": "Education Fund", "icon": Icons.book},
                  {"name": "Travel Fund", "icon": Icons.airplanemode_active},
                  {"name": "Investment Fund", "icon": Icons.trending_up},
                  {"name": "Other", "icon": Icons.more_horiz},
                ].map((option) {
                  return DropdownMenuItem<IconData>(
                    value: option['icon'] as IconData?,
                    child: Row(
                      children: [
                        Icon(option['icon'] as IconData, size: 24),
                        SizedBox(width: 8),
                        Text(option['name'] as String),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (icon) {
                  selectedIcon = icon;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final String title = titleController.text;
                if (title.isNotEmpty && selectedIcon != null) {
                  setState(() {
                    savings.add(Saving(title: title, icon: selectedIcon!));
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
