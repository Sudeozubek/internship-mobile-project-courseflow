import 'dart:convert';

import '../models/want_api_product.dart';
import 'network_fetch.dart';

/// Eğitim dokümanındaki demo API (wantapi.com).
class WantApiService {
  static const String productsUrl = 'https://wantapi.com/products.php';
  static const String bannerUrl = 'https://wantapi.com/assets/banner.png';

  Future<List<WantApiProduct>> fetchProducts() async {
    final String raw =
        await fetchHttpBody(Uri.parse(productsUrl));
    final Map<String, dynamic> decoded =
        jsonDecode(raw) as Map<String, dynamic>;
    final List<dynamic> data = decoded['data'] as List<dynamic>;
    return data
        .map(
          (dynamic e) =>
              WantApiProduct.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
