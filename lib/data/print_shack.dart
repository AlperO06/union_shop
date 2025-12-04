class PrintShackProduct {
  final String name;
  final double pricePerLine;
  final int maxCharsPerLine;
  final List<String> imageUrls;

  const PrintShackProduct({
    required this.name,
    required this.pricePerLine,
    required this.maxCharsPerLine,
    this.imageUrls = const [],
  })  : assert(pricePerLine >= 0),
        assert(maxCharsPerLine > 0);

  PrintShackProduct copyWith({
    String? name,
    double? pricePerLine,
    int? maxCharsPerLine,
    List<String>? imageUrls,
  }) {
    return PrintShackProduct(
      name: name ?? this.name,
      pricePerLine: pricePerLine ?? this.pricePerLine,
      maxCharsPerLine: maxCharsPerLine ?? this.maxCharsPerLine,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
