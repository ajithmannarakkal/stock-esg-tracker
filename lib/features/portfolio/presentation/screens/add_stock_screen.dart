import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/portfolio_provider.dart';

class AddStockScreen extends ConsumerStatefulWidget {
  const AddStockScreen({super.key});

  @override
  ConsumerState<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends ConsumerState<AddStockScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isAdding = false;
  List<Map<String, String>> _searchResults = [];
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () async {
      if (query.length < 2) {
        setState(() => _searchResults = []);
        return;
      }
      var results = await ref
          .read(portfolioProvider.notifier)
          .searchStocks(query);
      if (mounted) {
        setState(() => _searchResults = results);
      }
    });
  }

  Future<void> _addStock(String symbol) async {
    if (symbol.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a stock symbol')),
      );
      return;
    }

    setState(() => _isAdding = true);

    var notifier = ref.read(portfolioProvider.notifier);
    await notifier.addStock(symbol);

    setState(() => _isAdding = false);

    if (notifier.errorMessage != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(notifier.errorMessage!)),
        );
      }
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Stock')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: 'Stock Symbol',
                hintText: 'e.g. AAPL, TSLA, MSFT',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearchChanged,
            ),

            SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isAdding
                    ? null
                    : () => _addStock(_controller.text),
                child: _isAdding
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text('Add to Portfolio'),
              ),
            ),

            SizedBox(height: 16),

            // search results
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                      child: Text(
                        'Type at least 2 characters to search',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        var item = _searchResults[index];
                        return ListTile(
                          title: Text(item['symbol'] ?? ''),
                          subtitle: Text(
                            item['name'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(Icons.add_circle_outline),
                          onTap: () {
                            _controller.text = item['symbol'] ?? '';
                            setState(() => _searchResults = []);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}