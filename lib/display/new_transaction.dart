import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/data/data_source.dart';
import 'package:flutter_hf/model/transaction_model.dart';
import 'package:provider/provider.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({Key? key}) : super(key: key);

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

enum IncomeOrExpense { income, expense }

class _NewTransactionPageState extends State<NewTransactionPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  IncomeOrExpense? _income = IncomeOrExpense.income;
  late DataSource datasource;

  Future<void> saveToDatabase(Transaction transaction) async {
    return await datasource.upsertTransaction(transaction);
  }

  @override
  void initState() {
    super.initState();
    datasource = Provider.of<DataSource>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Új tranzakció felvétele"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
          child: Column(children: <Widget>[
            TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Tétel megnevezése",
                  labelStyle: TextStyle(color: Color(0xff75c018)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff75c018))),
                ),
                style: const TextStyle(color: Colors.white)),
            TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: "Tétel összege",
                  labelStyle: TextStyle(color: Color(0xff75c018)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff75c018))),
                ),
                style: const TextStyle(color: Colors.white)),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: const Text(
                      "Bevétel",
                      style: TextStyle(
                        color: Color(0xff75c018),
                      ),
                    ),
                    leading: Radio<IncomeOrExpense>(
                      value: IncomeOrExpense.income,
                      groupValue: _income,
                      onChanged: (IncomeOrExpense? value) {
                        setState(() {
                          _income = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      "Kiadás",
                      style: TextStyle(
                        color: Color(0xff75c018),
                      ),
                    ),
                    leading: Radio<IncomeOrExpense>(
                      value: IncomeOrExpense.expense,
                      groupValue: _income,
                      onChanged: (IncomeOrExpense? value) {
                        setState(() {
                          _income = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: const Color(0xff75c018),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Mégse'),
                  ),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: const Color(0xff75c018),
                      ),
                      onPressed: () {
                        DateTime today = DateTime.now();
                        String date = today.year.toString() +
                            "-" +
                            today.month.toString() +
                            "-" +
                            today.day.toString() +
                            "  " +
                            today.hour.toString() +
                            ":" +
                            today.minute.toString();

                        Transaction tr = Transaction(
                            title: titleController.text,
                            income: _income == IncomeOrExpense.income
                                ? true
                                : false,
                            amount: double.parse(amountController.text),
                            date: date);

                        saveToDatabase(tr);
                        Navigator.pop(context, "Mentés");
                      },
                      child: const Text('Mentés'),
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
