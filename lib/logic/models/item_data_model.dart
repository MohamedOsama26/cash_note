class Item {
  final int? id;
  late final String type;
  final String title;
  final String? subTitle;
  final double amount;
  final String creationDate;

  Item({
    this.id,
    required this.type,
    required this.title,
    this.subTitle,
    required this.amount,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'subtitle': subTitle,
      'amount': amount,
      'creation_date': creationDate,
    };
  }

  @override
  String toString() {
    return 'Item{ type: $type, title: $title, subtitle: $subTitle, amount: $amount, creation_date: $creationDate}';
  }
}
