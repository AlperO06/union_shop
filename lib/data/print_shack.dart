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

  factory PrintShackProduct.fromJson(Map<String, dynamic> json) {
    return PrintShackProduct(
      name: json['name'] as String? ?? '',
      pricePerLine: (json['pricePerLine'] is num) ? (json['pricePerLine'] as num).toDouble() : double.tryParse('${json['pricePerLine']}') ?? 0.0,
      maxCharsPerLine: (json['maxCharsPerLine'] is int) ? json['maxCharsPerLine'] as int : int.tryParse('${json['maxCharsPerLine']}') ?? 0,
      imageUrls: (json['imageUrls'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'pricePerLine': pricePerLine,
        'maxCharsPerLine': maxCharsPerLine,
        'imageUrls': imageUrls,
      };

  @override
  String toString() {
    return 'PrintShackProduct(name: $name, pricePerLine: $pricePerLine, maxCharsPerLine: $maxCharsPerLine, imageUrls: $imageUrls)';
  }
