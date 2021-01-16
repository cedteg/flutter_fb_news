// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'flutter_fb_news.dart';

class FbNewsService {
  static Future<http.Response> getFeed({
    String pageId,
    String token,
    int limit = 20,
    List<FbNewsFieldName> fields,
  }) async {
    var f = fields.map((e) => e.name).toList();
    return await http.get(
        "https://graph.facebook.com/v9.0/$pageId/feed?fields=id,created_time,likes{id},from,limit{$limit},shares,permalink_url,${f.join(",")}&access_token=$token");
  }

  static Future<http.Response> getProfilePicture({
    String pageId,
    String token,
  }) async {
    return await http.get(
        "https://graph.facebook.com/v9.0/$pageId?fields=picture&access_token=$token");
  }
}
