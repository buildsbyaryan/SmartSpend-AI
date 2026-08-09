class Budget {
  String? id;

  String category;

  double limit;

  double spent;

  int month;

  int year;

  Budget({
    this.id,
    required this.category,
    required this.limit,
    this.spent = 0,
    required this.month,
    required this.year,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json["_id"],

      category: json["category"] ?? "",

      limit: (json["limit"] ?? 0).toDouble(),

      spent: (json["spent"] ?? 0).toDouble(),

      month: json["month"] ?? 0,

      year: json["year"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category": category,

      "limit": limit,

      "spent": spent,

      "month": month,

      "year": year,
    };
  }
}
