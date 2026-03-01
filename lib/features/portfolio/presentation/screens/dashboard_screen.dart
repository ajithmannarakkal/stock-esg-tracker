import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/portfolio_provider.dart';
import '../widgets/stock_card.dart';
import 'add_stock_screen.dart';
import 'stock_details_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  Color _greenScoreColor(double score) {
    if (score >= 75) return Colors.green;
    if (score >= 60) return Colors.lightGreen;
    if (score >= 45) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var stocks = ref.watch(portfolioProvider);
    var notifier = ref.read(portfolioProvider.notifier);

    double totalValue = 0;
    double totalCO2 = 0;
    double totalESG = 0;

    for (var s in stocks) {
      totalValue += s.price;
      totalCO2 += s.co2;
      totalESG += s.esgScore;
    }

    double greenScore = stocks.isEmpty ? 0 : totalESG / stocks.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock ESG Tracker'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddStockScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: stocks.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bar_chart,
                      size: 64, color: Colors.grey[400]),
                  SizedBox(height: 12),
                  Text(
                    'No stocks in portfolio',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Tap + to add your first stock',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                // summary cards row
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        title: 'Portfolio Value',
                        value: '\$${totalValue.toStringAsFixed(2)}',
                        icon: Icons.account_balance_wallet,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Total CO₂',
                        value: '${totalCO2.toStringAsFixed(0)} t',
                        icon: Icons.cloud_outlined,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // green score card
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.eco,
                                color: _greenScoreColor(greenScore)),
                            SizedBox(width: 8),
                            Text(
                              'Green Score',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${greenScore.toStringAsFixed(1)} / 100',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: _greenScoreColor(greenScore),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: greenScore / 100,
                            minHeight: 10,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation(
                              _greenScoreColor(greenScore),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  'Holdings (${stocks.length})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),

                // stock list
                ...stocks.map(
                  (stock) => StockCard(
                    stock: stock,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              StockDetailsScreen(stock: stock),
                        ),
                      );
                    },
                    onDelete: () {
                      notifier.removeStock(stock.symbol);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}