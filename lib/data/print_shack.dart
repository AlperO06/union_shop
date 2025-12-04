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
