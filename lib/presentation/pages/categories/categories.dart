
import 'package:finance_application/presentation/pages/categories/savings_page.dart';
import 'package:flutter/material.dart';
import 'accounts_page.dart';
import 'expense_page.dart';
import 'income_page.dart';
import 'loans_page.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String title = "Categories";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.attach_money), text: "Income"),
            Tab(icon: Icon(Icons.money_off), text: "Expenses"),
            Tab(icon: Icon(Icons.savings), text: "Savings"),
            Tab(icon: Icon(Icons.account_balance), text: "Accounts"),
            Tab(icon: Icon(Icons.request_quote), text: "Loans")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          IncomePage(),
          ExpensesPage(),
          SavingsPage(),
          AccountsPage(),
          LoansPage()
        ],
      ),
    );
  }
}
