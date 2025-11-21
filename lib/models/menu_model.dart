class MenuModel {
  final String id;
  final String name;
  final String description;
  final int price;
  final String category;
  final String imageUrl;
  final double discount; // Nilai antara 0-1 (contoh: 0.2 = 20%)
  int quantity;

  MenuModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.discount = 0.0,
    this.quantity = 0,
  });

  // Menghitung harga setelah diskon
  int getDiscountedPrice() {
    return (price - (price * discount)).toInt();
  }

  MenuModel copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    String? category,
    String? imageUrl,
    double? discount,
    int? quantity,
  }) {
    return MenuModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      discount: discount ?? this.discount,
      quantity: quantity ?? this.quantity,
    );
  }
}