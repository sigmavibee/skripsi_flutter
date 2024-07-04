import 'package:dio/dio.dart';
import 'package:stunting_project/tokenmanager.dart';
import '../data/discussion/discussion_models.dart';

class DiscussionService {
  final Dio _dio = Dio();
  final String protocol = 'https'; // or 'http'
  final String host = 'www.givxl33t.site'; // Replace with your API host
  final String getDiscussionPath = '/api/forum';
  final String getDiscussionByIdPath =
      '/api/forum/:discussionId'; // Append article ID dynamically
  final String getUserPath = '/api/user/:userId';
  // final String updateDiscussionPath = '/api/forum/:discussionId';
  final String getLikePath = '/api/forum/:discussionId/like';

  DiscussionService() {
    _dio.options.baseUrl = '$protocol://$host';
    _dio.options.validateStatus = (status) {
      return status != null && status >= 200 && status <= 422;
    };
  }

  Future<List<Discussion>> getDiscussions() async {
    try {
      final accessToken = await TokenManager
          .getAccessToken(); // Get access token from TokenManager
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await _dio.get(
        getDiscussionPath,
        options: Options(headers: {
          'Authorization':
              'Bearer $accessToken', // Use the retrieved access token
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Discussion.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Invalid or expired token. Please login again.');
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    }
  }

  Future<Discussion> getDiscussionById(String discussionId) async {
    try {
      final accessToken = await TokenManager
          .getAccessToken(); // Get access token from TokenManager
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await _dio.get(
        getDiscussionByIdPath.replaceFirst(':discussionId', discussionId),
        options: Options(headers: {
          'Authorization':
              'Bearer $accessToken', // Use the retrieved access token
        }),
      );

      if (response.statusCode == 200) {
        return Discussion.fromJson(response.data['data']);
      }
      if (response.statusCode == 401) {
        throw Exception('message');
      } else {}
      if (response.statusCode == 422) {
        throw Exception('message');
      } else {}
      if (response.statusCode == 400) {
        throw Exception('message');
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    }
  }

  Future<Discussion> createDiscussion(
      Map<String, dynamic> discussionData) async {
    try {
      final accessToken = await TokenManager.getAccessToken();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await _dio.post(
        getDiscussionPath,
        data: discussionData,
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (response.statusCode == 201) {
        final responseData = response.data['data'];
        if (responseData == null || responseData['id'] == null) {
          throw Exception('Invalid response data');
        }
        return Discussion.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw Exception(response.data['message']);
      } else if (response.statusCode == 422) {
        throw Exception(response.data['message']);
      } else {
        throw Exception('Failed to create discussion');
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> updateDiscussion(
      String discussionId, Map<String, dynamic> discussionData) async {
    try {
      final accessToken = await TokenManager.getAccessToken();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await _dio.put(
        getDiscussionByIdPath.replaceFirst(':discussionId', discussionId),
        data: discussionData,
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (response.statusCode == 200) {
        print("Discussion successfully updated");
      } else if (response.statusCode == 401) {
        throw Exception(response.data['message']);
      } else if (response.statusCode == 403) {
        throw Exception(response.data['message']);
      } else if (response.statusCode == 422) {
        throw Exception(response.data['message']);
      } else if (response.statusCode == 400) {
        throw Exception(response.data['message']);
      } else {
        throw Exception('Failed to update discussion');
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> deleteDiscussion(String discussionId) async {
    try {
      final accessToken = await TokenManager.getAccessToken();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await _dio.delete(
        getDiscussionByIdPath.replaceFirst(':discussionId', discussionId),
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (response.statusCode == 200) {
        print("Discussion successfully deleted");
      } else if (response.statusCode == 401) {
        throw Exception(response.data['message']);
      } else {
        throw Exception('Failed to delete discussion');
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> likeDiscussion(String discussionId) async {
    try {
      final accessToken = await TokenManager.getAccessToken();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await _dio.post(
        getLikePath.replaceFirst(':discussionId', discussionId),
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (response.statusCode == 200) {
        print("Discussion successfully liked");
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> unlikeDiscussion(String discussionId) async {
    try {
      final accessToken = await TokenManager.getAccessToken();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await _dio.post(
        getLikePath.replaceFirst(':discussionId', discussionId),
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (response.statusCode == 200) {
        print("Discussion successfully unliked");
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    }
  }
}
