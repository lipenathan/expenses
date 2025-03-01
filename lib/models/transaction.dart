import 'package:expenses/components/adaptative/months.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final Month month;

  Transaction({
    required this.id, required this.title, required this.value, required this.month
  });
}