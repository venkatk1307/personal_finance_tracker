import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final List<Map<String, dynamic>> expenses = [
    {"title": "Rent", "icon": Icons.home, "amount": 0.0},
    {"title": "Utilities", "icon": Icons.lightbulb, "amount": 0.0},
    {"title": "Groceries", "icon": Icons.shopping_cart, "amount": 0.0},
    {"title": "Transportation", "icon": Icons.directions_car, "amount": 0.0},
    {"title": "Entertainment", "icon": Icons.local_movies, "amount": 0.0},
  ];

  double totalExpenses = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.0),
          // Total Income Display
          Column(
            children: [
              Text(
                "Total Expense",
                style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
              ),
              Text(
                "₹${totalExpenses.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                children: expenses.map((expense) {
                  return _buildExpenseBox(context, expense);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddExpenseTypeDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Expense Type',
      ),
    );
  }

  Widget _buildExpenseBox(BuildContext context, Map<String, dynamic> expense) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _showExpenseDialog(context, expense);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(expense['icon'], size: 30.0),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  expense['title'],
                  style: TextStyle(fontSize: 14.0),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExpenseDialog(BuildContext context, Map<String, dynamic> expense) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Amount for ${expense['title']}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: "Amount"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
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
                final double? amount = double.tryParse(amountController.text);
                if (amount != null && amount > 0) {
                  setState(() {
                    expense['amount'] = amount;
                    totalExpenses = expenses.fold(0.0, (sum, item) => sum + (item['amount'] as double));
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

  void _showAddExpenseTypeDialog(BuildContext context) {
    final TextEditingController typeController = TextEditingController();
    IconData? selectedIcon;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Expense Type"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: "Expense Type"),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<IconData>(
                decoration: InputDecoration(labelText: "Choose Icon"),
                items: [
                  {"name": "Home", "icon": Icons.home},
                  {"name": "Lightbulb", "icon": Icons.lightbulb},
                  {"name": "Shopping Cart", "icon": Icons.shopping_cart},
                  {"name": "Car", "icon": Icons.directions_car},
                  {"name": "Movies", "icon": Icons.local_movies},
                ].map((option) {
                  return DropdownMenuItem<IconData>(
                    value: option['icon'] as IconData,
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
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final String expenseType = typeController.text;
                if (expenseType.isNotEmpty && selectedIcon != null) {
                  setState(() {
                    expenses.add({"title": expenseType, "icon": selectedIcon, "amount": 0.0});
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