

abstract class TransactionRepository<T> {
  Future<void> init();

  Stream<List<T>> getAllTransactions();

  Future<T> getTransaction(int id);

  Future<void> upsertTransaction(T transaction);

  Future<void> deleteTransaction(T transaction);
}