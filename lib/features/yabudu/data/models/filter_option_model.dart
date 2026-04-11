class FilterOptionModel {
  final String id;
  final String label;
  final bool hasArrow;

  const FilterOptionModel({
    required this.id,
    required this.label,
    this.hasArrow = false,
  });
}
