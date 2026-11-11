import 'dart:convert';
import 'dart:io';

/// GET isteği (dart:io — ek paket yok).
Future<String> fetchHttpBody(Uri uri) async {
  final HttpClient client = HttpClient();
  try {
    final HttpClientRequest request = await client.getUrl(uri);
    request.headers.set(HttpHeaders.acceptHeader, 'application/json');
    final HttpClientResponse response = await request.close();
    final String body = await response.transform(utf8.decoder).join();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('HTTP ${response.statusCode}', uri: uri);
    }
    return body;
  } finally {
    client.close(force: true);
  }
}

/// POST + JSON gövde (ödev teslimi simülasyonu).
Future<String> postHttpJson(Uri uri, Map<String, dynamic> body) async {
  final HttpClient client = HttpClient();
  try {
    final HttpClientRequest request = await client.postUrl(uri);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));
    final HttpClientResponse response = await request.close();
    final String responseBody =
        await response.transform(utf8.decoder).join();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('HTTP ${response.statusCode}', uri: uri);
    }
    return responseBody;
  } finally {
    client.close(force: true);
  }
}
