import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/portfolio_provider.dart';
import 'add_stock_screen.dart';

class DashboardScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context,
      WidgetRef ref){

    var stocks =
    ref.watch(portfolioProvider);

    double totalValue=0;
    double totalCO2=0;
    double totalESG=0;

    for(var s in stocks){

      totalValue+=s.price;
      totalCO2+=s.co2;
      totalESG+=s.esgScore;

    }

    double greenScore=
    stocks.isEmpty?0:totalESG/stocks.length;

    return Scaffold(

        appBar:
        AppBar(title:Text("Dashboard")),

        floatingActionButton:
        FloatingActionButton(

          onPressed:(){

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder:(_)=>AddStockScreen()
                ));

          },

          child:Icon(Icons.add),

        ),

        body:Padding(

            padding:EdgeInsets.all(16),

            child:Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children:[

                  Text("Portfolio Value: \$${totalValue.toStringAsFixed(2)}"),

                  SizedBox(height:10),

                  Text("Total CO2: $totalCO2"),

                  SizedBox(height:10),

                  Text("Green Score: ${greenScore.toStringAsFixed(1)}"),

                  SizedBox(height:20),

                  Expanded(

                      child:ListView.builder(

                          itemCount:stocks.length,

                          itemBuilder:(c,i){

                            var s=stocks[i];

                            return ListTile(

                              title:Text(s.symbol),

                              subtitle:
                              Text("Price:${s.price} ESG:${s.esgScore}"),

                            );

                          })

                  )

                ]

            )

        )

    );

  }

}