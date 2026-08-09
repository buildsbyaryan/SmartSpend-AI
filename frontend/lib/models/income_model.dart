class Income {
  final String id;
  final String title;
  final double amount;
  final String category;
  final String description;
  final String paymentMethod;
  final DateTime date;

  Income({
    this.id = "",

    required this.title,

    required this.amount,

    required this.category,

    this.description = "",

    this.paymentMethod = "Cash",

    required this.date,
  });

  // JSON → OBJECT

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      id: json["_id"] ?? "",

      title: json["title"] ?? "",

      amount: (json["amount"] ?? 0).toDouble(),

      category: json["category"] ?? "",

      description: json["description"] ?? "",

      paymentMethod: json["paymentMethod"] ?? "Cash",

      date: DateTime.parse(json["date"]),
    );
  }

  // OBJECT → JSON

  Map<String, dynamic> toJson() {
    return {
      "title": title,

      "amount": amount,

      "category": category,

      "description": description,

      "paymentMethod": paymentMethod,

      "date": date.toIso8601String(),
    };
  }
}
