
import 'package:flutter_hf/data/repository/transaction_repository.dart';
import 'package:flutter_hf/model/transaction_model.dart';
import '../dao/floor_transaction_dao.dart';
import '../db/floor_transaction_database.dart';

class FloorTransactionRepository implements TransactionRepository<Transaction> {
  late FloorTransactionDao transactionDao;

  @override
  Future<void> init() async {
    final database = await $FloorFloorTransactionDatabase
        .databaseBuilder("floor_transaction.db")
        .build();
    transactionDao = database.transactionDao;
  }

  @override
  Stream<List<Transaction>> getAllTransactions() {
    return transactionDao.getAllTransactions();
  }

  @override
  Future<Transaction> getTransaction(int id) async {
    final transaction = await transactionDao.getTransaction(id);
    if(transaction == null) {
      throw Exception("Invalid TRANSACTION ID");
    } else {
      return transaction;
    }
  }

  @override
  Future<void> deleteTransaction(Transaction transaction) {
    return transactionDao.deleteTransaction(transaction.id ?? -1);
  }

  @override
  Future<void> upsertTransaction(Transaction transaction) {
    return transactionDao.upsertTransaction(transaction);
  }
}
