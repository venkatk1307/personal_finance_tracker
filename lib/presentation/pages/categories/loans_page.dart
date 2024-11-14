// loans_page.dart
import 'package:flutter/material.dart';

class LoansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          children: [
            _buildLoanBox("Personal Loan", Icons.money_off),
            _buildLoanBox("Home Loan", Icons.home),
            _buildLoanBox("Car Loan", Icons.directions_car),
            _buildLoanBox("Education Loan", Icons.book),
            _buildLoanBox("Business Loan", Icons.business),
            _buildLoanBox("Other", Icons.more_horiz),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanBox(String title, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Handle box tap if needed
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, size: 30.0),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  title,
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
}
