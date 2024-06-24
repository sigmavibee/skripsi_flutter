import 'package:dio/dio.dart';
import 'package:stunting_project/tokenmanager.dart';
import '../data/discussion/discussion_models.dart';

class DiscussionService {
  final Dio _dio = Dio();
  final String protocol = 'https'; // or 'http'
  final String host = 'www.givxl33t.site'; // Replace with your API host
  final String getDiscussionPath = '/api/forum';
  final String getDiscussionByIdPath = '/api/forum/:discussionId'; // Append article ID dynamically

  DiscussionService() {
    _dio.options.baseUrl = '$protocol://$host';
    _dio.options.validateStatus = (status) {
      return status != null && status >= 200 && status <= 422;
    };
  }

  Future<List<Discussion>> getDiscussions({String? sort, int? limit, int? page}) async {
    try {
      final accessToken = await TokenManager.getAccessToken(); // Get access token from TokenManager
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await _dio.get(
        getDiscussionPath,
        queryParameters: {
          if (sort != null) 'sort': sort,
          if (limit != null) 'limit': limit,
          if (page != null) 'page': page,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken', // Use the retrieved access token
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Discussion.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Invalid or expired token. Please login again.');
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load discussions');
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response!.data['message'] ?? 'Failed to load discussions';
      }
      throw Exception(errorMessage);
    }
  }

  
}