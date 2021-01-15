import 'package:flutter_fb_news/fb_news_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('getProfileFail', () {
    test('response code 400', () async {
      http.Response response = await FbNewsService.getProfilePicture(
        pageId: "1234567890",
        token: "xyz",
      );
      expect(response.statusCode, 400);
    });
    test('ExceptionMessage', () async {
      http.Response response = await FbNewsService.getProfilePicture(
        pageId: "1234567890",
        token: "xyz",
      );
      expect(response.body.contains('OAuthException'), true);
    });
  });
  group('getFeed', () {
    test('response code 400', () async {
      http.Response response = await FbNewsService.getFeed(
        pageId: "1234567890",
        token: "xyz",
        fields: [],
      );
      expect(response.statusCode, 400);
    });
    test('ExceptionMessage', () async {
      http.Response response = await FbNewsService.getFeed(
        pageId: "1234567890",
        token: "xyz",
        fields: [],
      );
      expect(response.body.contains('OAuthException'), true);
    });
  });
}
