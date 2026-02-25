import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/portfolio_provider.dart';

class AddStockScreen extends ConsumerWidget{

  TextEditingController controller=
  TextEditingController();

  @override
  Widget build(BuildContext context,
      WidgetRef ref){

    return Scaffold(

        appBar:
        AppBar(title:Text("Add Stock")),

        body:Padding(

            padding:EdgeInsets.all(20),

            child:Column(

                children:[

                  TextField(
                      controller:controller,
                      decoration:
                      InputDecoration(
                          labelText:"Symbol")),

                  SizedBox(height:20),

                  ElevatedButton(

                      onPressed:() async{

                        await ref
                            .read(portfolioProvider.notifier)
                            .addStock(controller.text);

                        Navigator.pop(context);

                      },

                      child:Text("Add")

                  )

                ]

            )

        )

    );

  }

}