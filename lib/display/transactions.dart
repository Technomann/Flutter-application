
import 'package:flutter/material.dart';
import 'package:flutter_hf/data/data_source.dart';
import 'package:flutter_hf/model/transaction_model.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

enum IncomeOrExpense { income, expense }

class _TransactionPageState extends State<TransactionPage> {
  late DataSource datasource;

  void handleClick(String choice){
    switch(choice){
      case "Kijelentkezés":
        Navigator.pop(context);
        break;
      case "Árfolyamok":
        Navigator.pushNamed(context, "/currencies");
    }
  }

  @override
  void initState() {
    datasource = Provider.of<DataSource>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Számlatörténet"),
        actions: <Widget>[
          PopupMenuButton<String>(
            color: const Color(0xff75c018),
            onSelected: handleClick,
              itemBuilder: (BuildContext context){
                return {'Árfolyamok', 'Kijelentkezés'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }
          ),
        ],
      ),
      body: Center(
          child: StreamBuilder<List<Transaction>>(
            stream: datasource.getAllTransactions(),//getTransactionsFromDB(),//list,
            builder: (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
              if(snapshot.connectionState == ConnectionState.none && snapshot.data == null){
                return const Text("Valami hiba van");
              }else if(snapshot.data != null){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Transaction item = snapshot.data![index];
                    var image = item.income
                        ? Image.asset("assets/images/plus.png")
                        : Image.asset("assets/images/minus.png");
                    return Card(
                      color: const Color(0xaaffffff),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: image)
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(item.title),
                                  Text(item.amount.toStringAsFixed(0) + "Ft")
                                ]
                              )
                            ),
                            Expanded(
                                child: Text(item.date)
                            )
                          ]
                        )
                      )
                    );
                  },
                );
              }else{
                return const Center(
                  child: Text("Üres az adatbázis!")
                );
              }
            })
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/newtransactionpage"),
        tooltip: 'Új tranzakció felvétele',
        child: const Icon(Icons.add),
      ),
    );
  }
}
