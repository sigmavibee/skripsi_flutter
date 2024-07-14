import 'package:dio/dio.dart';
import 'package:stunting_project/data/gizi/gizi_models.dart';

import '../data/gizi/children_models.dart';

class GiziService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://www.givxl33t.site/api/bmi';
  final String getUserNutritionHistoriesurl =
      'https://www.givxl33t.site/api/bmi/me';
  final String getChildrenPath = 'https://www.givxl33t.site/api/bmi/children';
  final String getChildrenIdPath = '/api/bmi/children/:childId';

  Future<NutritionHistory> createNutritionHistory({
    required String childName,
    required String ageText,
    required DateTime birthDate,
    required String childNik,
    required String childVillage,
    required String height,
    required String weight,
    required String gender,
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: {
          'child_nik': childNik,
          'child_name': childName,
          'child_village': childVillage,
          'date_of_birth': birthDate.toIso8601String(),
          'age_text': ageText,
          'height': height,
          'weight': weight,
          'gender': gender,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 201) {
        return NutritionHistory.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to create nutrition history');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        final errorCode = errorData['code'];
        final errorMessage = errorData['message'];
        throw Exception('$errorCode: $errorMessage');
      } else {
        throw Exception('Failed to connect to server');
      }
    }
  }

  Future<List<NutritionHistory>> getUserNutritionHistories(String token) async {
    try {
      final response = await _dio.get(
        getUserNutritionHistoriesurl,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        print('Received data: $data');

        return data
            .map((history) => NutritionHistory.fromJson(history))
            .toList();
      } else {
        throw Exception('Failed to get user nutrition histories');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        final errorCode = errorData['code'];
        final errorMessage = errorData['message'];
        throw Exception('$errorCode: $errorMessage');
      } else {
        throw Exception('Failed to connect to server');
      }
    }
  }

  Future<NutritionHistory> getNutritionHistoryById({
    required String nutritionHistoryId,
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/$nutritionHistoryId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        return NutritionHistory.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to get nutrition history');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        final errorCode = errorData['code'];
        final errorMessage = errorData['message'];
        throw Exception('$errorCode: $errorMessage');
      } else {
        throw Exception('Failed to connect to server');
      }
    }
  }

  Future<List<Child>> getChildren(String token) async {
    try {
      final response = await _dio.get(
        getChildrenPath,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];

        // Debugging: Log the raw data received
        print('Received data: $data');

        // Process and validate each child entry
        return data.map((childJson) {
          try {
            // Attempt to parse each child entry
            return Child.fromJson(childJson);
          } catch (e) {
            // Log details of the error and the problematic data
            print('Error parsing child data: $childJson');
            print('Error details: $e');
            // Optionally: rethrow or return a default/fallback Child object
            throw Exception('Failed to parse child data: $e');
          }
        }).toList();
      } else {
        throw Exception('Failed to get children data');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        final errorCode = errorData['code'];
        final errorMessage = errorData['message'];
        throw Exception('$errorCode: $errorMessage');
      } else {
        throw Exception('Failed to connect to server');
      }
    } catch (e) {
      // Log any other unexpected errors
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<List<Child>> getChildrenById(String token) async {
    try {
      final response = await _dio.get(
        getChildrenIdPath,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];

        // Debugging: Log the raw data received
        print('Received data: $data');

        // Process and validate each child entry
        return data.map((childJson) {
          try {
            // Attempt to parse each child entry
            return Child.fromJson(childJson);
          } catch (e) {
            // Log details of the error and the problematic data
            print('Error parsing child data: $childJson');
            print('Error details: $e');
            // Optionally: rethrow or return a default/fallback Child object
            throw Exception('Failed to parse child data: $e');
          }
        }).toList();
      } else {
        throw Exception('Failed to get children data');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        final errorCode = errorData['code'];
        final errorMessage = errorData['message'];
        throw Exception('$errorCode: $errorMessage');
      } else {
        throw Exception('Failed to connect to server');
      }
    } catch (e) {
      // Log any other unexpected errors
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<List<NutritionHistory>> getUserNutritionHistoriesByChild(
      String accessToken) async {
    try {
      final response = await _dio.get(
        '$baseUrl/:nutritionHistoryId/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      List<dynamic> data = response.data;
      return data.map((history) => NutritionHistory.fromJson(history)).toList();
    } catch (e) {
      throw Exception('Failed to fetch nutrition histories: $e');
    }
  }

  Future<NutritionHistory> updateNutritionHistory({
    required String nutritionHistoryId,
    required String ageInMonth,
    required String height,
    required String weight,
    required String token,
  }) async {
    try {
      final data = {
        'age_in_month': ageInMonth,
        'height': height,
        'weight': weight,
      };

      // Print the data before sending it
      print('Data to be sent: $data');

      final response = await _dio.put(
        '$baseUrl/$nutritionHistoryId'
            .replaceFirst(':nutritionHistoryId', nutritionHistoryId),
        data: data,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        print('Nutrition history successfully updated');
        return NutritionHistory.fromJson(response.data['data']);
      } else {
        throw Exception(
            'Failed to update nutrition history: ${response.data['message']}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        final errorCode = e.response!.statusCode;
        final errorMessage = errorData['message'];

        // Print the error data for debugging
        print('Error data: $errorData');

        switch (errorCode) {
          case 401:
            throw Exception('Unauthorized: $errorMessage');
          case 422:
            // Handle validation errors specifically for 422 status code
            final validationErrors = errorData['errors'];
            if (validationErrors != null) {
              final formattedErrors = validationErrors.entries.map((entry) {
                final field = entry.key;
                final messages = (entry.value as List).join(', ');
                return '$field: $messages';
              }).join('\n');
              throw Exception('Unprocessable Entity:\n$formattedErrors');
            } else {
              throw Exception('Unprocessable Entity: $errorMessage');
            }
          case 400:
            throw Exception('Bad Request: $errorMessage');
          case 403:
            throw Exception('Forbidden: $errorMessage');
          default:
            throw Exception('Error: $errorMessage');
        }
      } else {
        print('Failed to connect to server');
        throw Exception('Failed to connect to server');
      }
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<NutritionHistory> deleteNutritionHistoryById({
    required String nutritionHistoryId,
    required String token,
  }) async {
    try {
      final response = await _dio.delete(
        '$baseUrl/$nutritionHistoryId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        return NutritionHistory.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to delete nutrition history');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        final errorCode = errorData['code'];
        final errorMessage = errorData['message'];
        throw Exception('$errorCode: $errorMessage');
      } else {
        throw Exception('Failed to connect to server');
      }
    }
  }
}
