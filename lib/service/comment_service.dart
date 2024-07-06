import 'package:dio/dio.dart';
import 'package:stunting_project/tokenmanager.dart';
import '../data/discussion/comment_models.dart';

class CommentService {
  final Dio _dio = Dio();
  final String protocol = 'https';
  final String host = 'www.givxl33t.site';
  final String getCommentsPath = '/api/forum/:discussionId/comment';

  CommentService() {
    _dio.options.baseUrl = '$protocol://$host';
    _dio.options.validateStatus = (status) {
      return status != null && status >= 200 && status <= 422;
    };
  }

  Future<List<Comment>?> getComments(String discussionId, {int? page}) async {
    final accessToken = await TokenManager.getAccessToken();
    final url = getCommentsPath.replaceFirst(':discussionId', discussionId);

    try {
      final queryParams = {};
      if (page != null) {
        queryParams['page'] = page.toString();
      }

      final response = await _dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 200) {
        final List<Comment> comments = [];
        for (var commentData in response.data['data'] as List) {
          comments.add(Comment.fromJson(commentData as Map<String, dynamic>));
        }

        return comments;
      } else if (response.statusCode == 401) {
        if (response.data['message'] ==
            'Invalid or Expired token. Please login again.') {
          print('Token expired or invalid.');
        } else if (response.data['message'] ==
            'Authorization Header missing.') {
          print('Authorization header missing.');
        }
      } else if (response.statusCode == 422) {
        print('Validation error: ${response.data['message']}');
      } else {
        print('Failed to load comments (${response.statusCode})');
        throw Exception('Failed to load comments (${response.statusCode})');
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
