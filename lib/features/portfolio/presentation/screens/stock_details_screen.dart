import 'package:flutter/material.dart';
import '../../domain/entities/stock.dart';

class StockDetailsScreen extends StatelessWidget {
  final Stock stock;

  const StockDetailsScreen({super.key, required this.stock});

  Color _ratingColor(String rating) {
    switch (rating) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.lightGreen;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.deepOrange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color ratingCol = _ratingColor(stock.sustainabilityRating);

    return Scaffold(
      appBar: AppBar(title: Text(stock.symbol)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // price section
            Center(
              child: Column(
                children: [
                  Text(
                    '\$${stock.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Current Price',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // ESG rating card
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sustainability',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 14),

                    // rating badge
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: ratingCol.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            stock.sustainabilityRating,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: ratingCol,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sustainability Rating',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                _ratingLabel(stock.sustainabilityRating),
                                style: TextStyle(
                                  color: ratingCol,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18),

                    // ESG score bar
                    Text('ESG Score: ${stock.esgScore.toStringAsFixed(0)} / 100'),
                    SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: stock.esgScore / 100,
                        minHeight: 10,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(ratingCol),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // CO2 emissions card
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Carbon Footprint',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.cloud_outlined,
                            color: Colors.blueGrey, size: 28),
                        SizedBox(width: 12),
                        Text(
                          '${stock.co2.toStringAsFixed(0)} tonnes CO₂',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Estimated annual carbon emissions',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _ratingLabel(String rating) {
    switch (rating) {
      case 'A':
        return 'Excellent sustainability practices';
      case 'B':
        return 'Good sustainability practices';
      case 'C':
        return 'Average sustainability practices';
      case 'D':
        return 'Below average sustainability';
      default:
        return 'Poor sustainability practices';
    }
  }
}
