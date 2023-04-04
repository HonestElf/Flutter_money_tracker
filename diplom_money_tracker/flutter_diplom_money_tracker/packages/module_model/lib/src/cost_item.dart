class CostItem {
  final num costPrice;
  final String costDay;

  CostItem({required this.costPrice, required this.costDay});

  factory CostItem.fromJson(Map<String, Object?> json) => CostItem(
        costDay: json['date'] as String,
        costPrice: (json['price'] as num),
      );

  Map<String, Object?> toJson() => {
        'date': costDay,
        'price': costPrice,
      };
}
