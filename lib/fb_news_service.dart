import 'package:http/http.dart' as http;

class FbNewsService {
  Future<http.Response> getFeed({
    String pageId,
    String token,
    int limit = 20,
  }) async {
    return await http.get(
        "https://graph.facebook.com/v9.0/$pageId/feed?fields=id,full_picture,created_time,message,attachments,likes{id},shares,permalink_url,from,limit{$limit}&access_token=$token");
  }
}
