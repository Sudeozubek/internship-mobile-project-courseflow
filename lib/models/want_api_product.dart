import 'course.dart';

/// wantapi.com/products.php yanıtındaki ürün kaydı.
class WantApiProduct {
  const WantApiProduct({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.image,
  });

  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price;
  final String image;

  factory WantApiProduct.fromJson(Map<String, dynamic> json) {
    return WantApiProduct(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: json['tagline'] as String? ?? '',
      description: json['description'] as String,
      price: json['price'] as String? ?? '',
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  /// Katalog kartları mevcut [Course] UI ile gösterilir.
  Course toCourse() {
    return Course(
      id: id,
      name: name,
      code: 'KAT-$id',
      instructor: tagline.isEmpty ? 'Katalog' : tagline,
      description: description,
      credits: 0,
      task: 'Kaynakları inceleyin; haftalık özet notu hazırlayın.',
      image: image,
      price: price.isEmpty ? null : price,
      fromApi: true,
    );
  }
}
