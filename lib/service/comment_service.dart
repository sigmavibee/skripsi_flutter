import 'package:dio/dio.dart';
import 'package:stunting_project/tokenmanager.dart';
import '../data/discussion/comment_models.dart';

class CommentService {
  final Dio _dio = Dio();
  final String protocol = 'https';
  final String host = 'www.givxl33t.site';
  final String getCommentsPath = '/api/forum/:discussionId/comment';
  final String createCommentPath = '/api/forum/:discussionId/comment';

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
        } else if (response.data['message'] ==
            'Authorization Header missing.') {}
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

  Future<bool> createComment(String discussionId, String content) async {
    final accessToken = await TokenManager.getAccessToken();
    final url = createCommentPath.replaceFirst(':discussionId', discussionId);

    try {
      final response = await _dio.post(
        url,
        data: {'comment_content': content},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 401) {
        if (response.data['message'] ==
            'Invalid or Expired token. Please login again.') {
        } else if (response.data['message'] ==
            'Authorization Header missing.') {
          ;
        }
      } else if (response.statusCode == 422) {
        print('Validation error: ${response.data['message']}');
      } else if (response.statusCode == 400) {
        print('message');
      } else {
        print('Failed to create comment (${response.statusCode})');
        throw Exception('Failed to create comment (${response.statusCode})');
      }
    } catch (e) {
      print('Error creating comment: $e');
      return false;
    }
    return false;
  }

  Future<void> updateComment(
      String commentId, Map<String, dynamic> commentData) async {
    final accessToken = await TokenManager.getAccessToken();
    final url = '/api/forum/comment/$commentId';

    try {
      final response = await _dio.put(
        url,
        data: commentData,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        print('Response data: ${response.data}');
        if (response.statusCode == 401) {
          if (response.data['message'] ==
              'Invalid or Expired token. Please login again.') {
            throw Exception('Invalid or Expired token. Please login again.');
          } else if (response.data['message'] ==
              'Authorization Header missing.') {
            throw Exception('Authorization Header missing.');
          }
        } else if (response.statusCode == 422) {
          throw Exception('Validation error: ${response.data['message']}');
        } else if (response.statusCode == 403) {
          throw Exception('Forbidden: ${response.data['message']}');
        } else {
          throw Exception(
              'Failed to update comment (${response.statusCode}): ${response.data}');
        }
      }
    } catch (e) {
      print('Error updating comment: $e');
      throw e;
    }
  }

  Future<void> deleteComment(String commentId) async {
    final accessToken = await TokenManager.getAccessToken();
    final url = '/api/forum/comment/$commentId';

    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        print('Response data: ${response.data}');
        if (response.statusCode == 401) {
          if (response.data['message'] ==
              'Invalid or Expired token. Please login again.') {
            throw Exception('Invalid or Expired token. Please login again.');
          } else if (response.data['message'] ==
              'Authorization Header missing.') {
            throw Exception('Authorization Header missing.');
          }
        } else if (response.statusCode == 422) {
          throw Exception('Validation error: ${response.data['message']}');
        } else if (response.statusCode == 403) {
          throw Exception('Forbidden: ${response.data['message']}');
        } else {
          throw Exception(
              'Failed to update comment (${response.statusCode}): ${response.data}');
        }
      }
    } catch (e) {
      print('Error updating comment: $e');
      throw e;
    }
  }
}
