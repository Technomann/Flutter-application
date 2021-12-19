
import 'package:flutter/material.dart';
import 'package:flutter_hf/model/currency.dart';
import 'package:flutter_hf/network/currency_repository.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage>{

  final repository = CurrencyRepository();
  Future<List<Currency>>? listRequest;

  @override
  void initState() {
    listRequest = repository.getCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Árfolyamok")
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          var request = repository.getCurrencies();
          setState(() {
            listRequest = request;
          });
          await request;
        },
        child: FutureBuilder<List<Currency>>(
          future: listRequest,
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text("Hiba történt: ${snapshot.error}")
              );
            }else if(snapshot.hasData){
              var list = snapshot.data!;
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return ListItem(list[index]);
                },
                itemCount: list.length,
              );
            }else{
              return const Center(
                child: CircularProgressIndicator()
              );
            }
          }
        )
      ),
    );
  }
}

class ListItem extends StatelessWidget{
  final Currency item;
  const ListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Card(
      color: const Color(0xaa75c018),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(item.name + " -> HUF")
            ),
            Expanded(
                child: Text(item.value!.toStringAsFixed(3)+"Ft")
            ),
            Expanded(
                child: Text(item.date)
            ),
          ],
        ),
      )
    );
  }
}