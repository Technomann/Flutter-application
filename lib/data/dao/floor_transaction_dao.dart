
import 'package:floor/floor.dart';
import 'package:flutter_hf/model/transaction_model.dart';

@dao
abstract class FloorTransactionDao{

  @Query("SELECT * FROM transaction_table")
  Stream<List<Transaction>> getAllTransactions();

  @Query("SELECT * FROM transaction_table WHERE id = :id")
  Future<Transaction?> getTransaction(int id);

  @Query("DELETE FROM transaction_table WHERE id = :id")
  Future<void> deleteTransaction(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertTransaction(Transaction transaction);
}
