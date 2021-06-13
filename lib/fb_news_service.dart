// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'flutter_fb_news.dart';

/// Only for internal use of flutter_fb_news
class FbNewsService {
  /// Only for internal use of flutter_fb_news
  static Future<http.Response> getFeed({
    required String pageId,
    required String token,
    required int limit,
    required List<FbNewsFieldName> fields,
  }) async {
    var f = fields.map((e) => e.facebookKey).toSet().toList();
    return await http.get(
      Uri.parse(
        "https://graph.facebook.com/v10.0/$pageId/feed?fields=id,created_time,from,shares,permalink_url,${f.join(",")}&access_token=$token&limit=$limit",
      ),
    );
  }

  /// Only for internal use of flutter_fb_news
  static Future<http.Response> getProfilePicture({
    required String pageId,
    required String token,
  }) async {
    return await http.get(
      Uri.parse(
        "https://graph.facebook.com/v10.0/$pageId?fields=picture&access_token=$token",
      ),
    );
  }
}
