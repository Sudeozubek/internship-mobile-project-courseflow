import 'dart:async';
import 'dart:convert';
// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

/// GET isteği (web — ek paket yok).
Future<String> fetchHttpBody(Uri uri) async {
  final Completer<String> done = Completer<String>();
  final html.HttpRequest request = html.HttpRequest();
  request.open('GET', uri.toString());
  request.setRequestHeader('Accept', 'application/json');
  request.onLoad.listen((_) {
    final int status = request.status ?? 0;
    if (status >= 200 && status < 300) {
      done.complete(request.responseText ?? '');
    } else {
      done.completeError(Exception('HTTP $status'));
    }
  });
  request.onError.listen((_) {
    done.completeError(Exception('Ağ hatası'));
  });
  request.send();
  return done.future;
}

/// POST + JSON gövde (web).
Future<String> postHttpJson(Uri uri, Map<String, dynamic> body) async {
  final Completer<String> done = Completer<String>();
  final html.HttpRequest request = html.HttpRequest();
  request.open('POST', uri.toString());
  request.setRequestHeader('Content-Type', 'application/json');
  request.onLoad.listen((_) {
    final int status = request.status ?? 0;
    if (status >= 200 && status < 300) {
      done.complete(request.responseText ?? '');
    } else {
      done.completeError(Exception('HTTP $status'));
    }
  });
  request.onError.listen((_) {
    done.completeError(Exception('Ağ hatası'));
  });
  request.send(jsonEncode(body));
  return done.future;
}
