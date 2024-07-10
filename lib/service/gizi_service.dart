import 'package:dio/dio.dart';
import 'package:stunting_project/data/gizi/gizi_models.dart';

class GiziService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://www.givxl33t.site/api/bmi';

  Future<NutritionHistory> createNutritionHistory({
    required String childName,
    required String ageText,
    required DateTime birthDate,
    required String childNik,
    required String childVillage,
    required int height,
    required int weight,
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
          'date_of_birth': birthDate
              .toIso8601String(), // Convert DateTime to ISO 8601 string
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
}
