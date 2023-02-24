class SaleData {
  final String uuid;
  final String day;
  final double value;
  final bool visible;

  const SaleData({
    required this.uuid,
    required this.day,
    required this.value,
    this.visible = true,
  });

  String get valueK {
    return '${value ~/ 1000}K';
  }

  SaleData copyWith({
    String? uuid,
    String? day,
    double? value,
    bool? visible,
  }) {
    return SaleData(
      uuid: uuid ?? this.uuid,
      day: day ?? this.day,
      value: value ?? this.value,
      visible: visible ?? this.visible,
    );
  }
}
