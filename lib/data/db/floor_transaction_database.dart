import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_hf/data/dao/floor_transaction_dao.dart';
import 'package:flutter_hf/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'floor_transaction_database.g.dart';

@Database(version: 1, entities: [Transaction])
abstract class FloorTransactionDatabase extends FloorDatabase{
  FloorTransactionDao get transactionDao;
}