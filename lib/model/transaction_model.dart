import 'package:floor/floor.dart';

@Entity(tableName: "transaction_table")
class Transaction{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final bool income;
  final double amount;
  final String date;

  Transaction(
    {
      this.id,
      required this.title,
      required this.income,
      required this.amount,
      required this.date
    }
  );
}