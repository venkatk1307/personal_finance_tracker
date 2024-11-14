import 'package:flutter/material.dart';

class Account {
  final String title;
  final IconData icon;
  double amount;

  Account({required this.title, required this.icon, this.amount = 0.0});
}

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  // List to store account information
  List<Account> accounts = [
    Account(title: "Savings Account", icon: Icons.account_balance),
  ];

  // Function to calculate the total balance
  double get totalBalance {
    return accounts.fold(0.0, (sum, account) => sum + account.amount);
  }

  // Function to handle adding a new account
  void _showAddAccountDialog() {
    final TextEditingController titleController = TextEditingController();
    IconData? selectedIcon;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Account"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Account Title"),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<IconData>(
                decoration: InputDecoration(labelText: "Choose Icon"),
                items: [
                  {"name": "Credit Card", "icon": Icons.credit_card},
                  {"name": "Savings Account", "icon": Icons.account_balance},
                  {"name": "Investment", "icon": Icons.trending_up},
                  {"name": "Loan Account", "icon": Icons.business_center},
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
                    accounts.add(Account(title: title, icon: selectedIcon!));
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

  // Function to show a dialog to update the amount for an account
  void _showUpdateAmountDialog(Account account) {
    final TextEditingController amountController = TextEditingController();
    amountController.text = account.amount.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Amount for ${account.title}"),
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
                    account.amount = amount;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.0),
          // Total Balance Display
          Column(
            children: [
              Text(
                "Total Balance",
                style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
              ),
              Text(
                "₹${totalBalance.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          // Accounts Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                children: accounts.map((account) {
                  return _buildAccountBox(account);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAccountDialog,
        child: Icon(Icons.add),
        tooltip: 'Add New Account',
      ),
    );
  }

  // Widget to build each account card
  Widget _buildAccountBox(Account account) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _showUpdateAmountDialog(account);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(account.icon, size: 30.0),
              SizedBox(height: 8.0),
              Expanded(
                child: Text(
                  account.title,
                  style: TextStyle(fontSize: 14.0),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis, // Truncate if text is too long
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                "₹${account.amount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 14.0, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
