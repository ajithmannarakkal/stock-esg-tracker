import 'package:flutter/material.dart';
import '../../domain/entities/stock.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const StockCard({
    super.key,
    required this.stock,
    this.onTap,
    this.onDelete,
  });

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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Row(
            children: [
              // symbol badge
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _ratingColor(stock.sustainabilityRating)
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  stock.sustainabilityRating,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: _ratingColor(stock.sustainabilityRating),
                  ),
                ),
              ),
              SizedBox(width: 14),

              // stock info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.symbol,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ESG: ${stock.esgScore.toStringAsFixed(0)}  •  CO₂: ${stock.co2.toStringAsFixed(0)} tonnes',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${stock.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Rating: ${stock.sustainabilityRating}',
                    style: TextStyle(
                      fontSize: 12,
                      color: _ratingColor(stock.sustainabilityRating),
                    ),
                  ),
                ],
              ),

              // delete button
              if (onDelete != null)
                IconButton(
                  icon: Icon(Icons.close, size: 18, color: Colors.grey),
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
