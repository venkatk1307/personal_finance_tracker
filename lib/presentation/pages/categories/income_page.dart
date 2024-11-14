import 'package:flutter/material.dart';

// Custom Model Class for Income
class Income {
  final String title;
  final IconData icon;
  double amount;

  Income({required this.title, required this.icon, this.amount = 0.0});
}

class IncomePage extends StatefulWidget {
  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  // List of Income Types
  final List<Income> incomeTypes = [
    Income(title: "Salary", icon: Icons.work),
    Income(title: "Investments", icon: Icons.attach_money),
    Income(title: "Freelancing", icon: Icons.business_center),
    Income(title: "Rent", icon: Icons.home),
    Income(title: "Dividends", icon: Icons.pie_chart),
  ];

  // Method to calculate total income
  double get totalIncome => incomeTypes.fold(0.0, (sum, income) => sum + income.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32.0),
          // Total Income Section
          Column(
            children: [
              Text(
                "Total Income",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8.0),
              Text(
                "₹${totalIncome.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                "Manage your income sources",
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          // Income Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                children: incomeTypes.map((income) {
                  return _buildIncomeBox(context, income);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddIncomeTypeDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Income Type',
      ),
    );
  }

  // Widget to build an income box
  Widget _buildIncomeBox(BuildContext context, Income income) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _showIncomeDialog(context, income);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(income.icon, size: 30.0),
              SizedBox(height: 8.0),
              Expanded(
                child: Text(
                  income.title,
                  style: TextStyle(fontSize: 14.0),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                "₹${income.amount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 14.0, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog to edit amount for an income type
  void _showIncomeDialog(BuildContext context, Income income) {
    final TextEditingController amountController = TextEditingController();

    amountController.text = income.amount.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Amount for ${income.title}"),
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
                    income.amount = amount;
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

  // Dialog to add a new income category
  void _showAddIncomeTypeDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    IconData? selectedIcon;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Income Category"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Income Category Name"),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<IconData>(
                decoration: InputDecoration(labelText: "Choose Icon"),
                items: [
                  {"name": "Salary", "icon": Icons.work},
                  {"name": "Investments", "icon": Icons.attach_money},
                  {"name": "Freelancing", "icon": Icons.business_center},
                  {"name": "Rent", "icon": Icons.home},
                  {"name": "Dividends", "icon": Icons.pie_chart},
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
                final String incomeType = titleController.text;
                if (incomeType.isNotEmpty && selectedIcon != null) {
                  setState(() {
                    incomeTypes.add(Income(
                      title: incomeType,
                      icon: selectedIcon!,
                    ));
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
