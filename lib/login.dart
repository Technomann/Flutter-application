
import 'package:flutter/material.dart';
import 'package:flutter_hf/data/data_source.dart';
import 'package:flutter_hf/data/repository/floor_transaction_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'display/currencies.dart';
import 'display/new_transaction.dart';
import 'display/transactions.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(117, 192, 24, .1),
  100: const Color.fromRGBO(117, 192, 24, .2),
  200: const Color.fromRGBO(117, 192, 24, .3),
  300: const Color.fromRGBO(117, 192, 24, .4),
  400: const Color.fromRGBO(117, 192, 24, .5),
  500: const Color.fromRGBO(117, 192, 24, .6),
  600: const Color.fromRGBO(117, 192, 24, .7),
  700: const Color.fromRGBO(117, 192, 24, .8),
  800: const Color.fromRGBO(117, 192, 24, .9),
  900: const Color.fromRGBO(117, 192, 24, 1),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final datasource = DataSource(FloorTransactionRepository());
  await datasource.init();

  runApp(Provider<DataSource>(
    create: (_) => datasource,
    child: const BankMeisterApp(),
  ));
}

class BankMeisterApp extends StatelessWidget {
  const BankMeisterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BankMeister Pro',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xff75c018, color),
          scaffoldBackgroundColor: const Color(0x00000000),
          unselectedWidgetColor: const Color(0xaaffffff),
        ),
        home: const LoginPage(title: 'BankMeister Pro'),
        routes: {
          "/transactionpage": (context) => const TransactionPage(),
          "/newtransactionpage": (context) => const NewTransactionPage(),
          "/currencies": (context) => const CurrencyPage()
        });
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const PIN_CODE_KEY = "PIN_CODE_KEY";
  String? _pinCode;

  Future<String?> getPinCode() async {
    final prefs = await SharedPreferences.getInstance();
    _pinCode = await prefs.getString(PIN_CODE_KEY) ?? null;
    return _pinCode;
  }

  void showToast(String _msg) {
    Fluttertoast.showToast(
        msg: _msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> setPinCode(String newPin) async {
    if (newPin == "") {
      showToast("A PIN kód nem lehet üres!");
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PIN_CODE_KEY, newPin);
      _pinCode = newPin;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _pinController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("BankMeister Pro"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: "PIN kód:",
                  labelStyle: TextStyle(color: Color(0xff75c018)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff75c018))),
                ),
                cursorColor: const Color(0xff75c018),
                controller: _pinController,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            FutureBuilder<String?>(
              future: getPinCode(),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 50.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: const Color(0xff75c018),
                            ),
                            onPressed: () {
                              if (_pinCode == _pinController.text) {
                                Navigator.pushNamed(
                                  context,
                                  "/transactionpage",
                                );
                              } else {
                                showToast("Hibás PIN kód!");
                              }
                            },
                            child: const Text('Belépés'),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: const Color(0xff75c018),
                            ),
                            onPressed: () {
                              setPinCode(_pinController.text);
                              Navigator.pushNamed(
                                context,
                                "/transactionpage",
                              );
                            },
                            child: const Text('PIN kód megadása'),
                          )
                        )
                      )
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
