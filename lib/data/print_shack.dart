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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PrintShackProduct) return false;
    return other.name == name &&
        other.pricePerLine == pricePerLine &&
        other.maxCharsPerLine == maxCharsPerLine &&
        _listEquals(other.imageUrls, imageUrls);
  }

  @override
  int get hashCode => Object.hash(name, pricePerLine, maxCharsPerLine, Object.hashAll(imageUrls));

  static bool _listEquals(List<String> a, List<String> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

// Sample Print Shack product
const PrintShackProduct samplePersonalisedHoodie = PrintShackProduct(
  name: 'Personalised Hoodie',
  pricePerLine: 3.0,
  maxCharsPerLine: 10,
  imageUrls: [
    // Unsplash images for hoodies (publicly served)
    'https://images.unsplash.com/photo-1520975911068-9d9b15743f85?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1520975698514-0a7b8c3f1c0e?auto=format&fit=crop&w=1200&q=80',
  ],
);
