
import 'package:flutter_hf/data/repository/transaction_repository.dart';
import 'package:flutter_hf/model/transaction_model.dart';

class DataSource{
  final TransactionRepository<Transaction> database;

  DataSource(this.database);

  Future<void> init() async {
    await database.init();
  }

  Stream<List<Transaction>> getAllTransactions() {
    final transactions = database.getAllTransactions();
    return transactions;
  }

  Future<Transaction> getTransaction(int id) async{
    final floorTransaction = await database.getTransaction(id);
    return floorTransaction;
  }

  Future<void> upsertTransaction(Transaction transaction) async{
    return database.upsertTransaction(transaction);
  }

  Future<void> deleteTransaction(Transaction transaction) async{
    return database.deleteTransaction(transaction);
  }
}
