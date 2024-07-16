// consultation_service.dart
import 'package:dio/dio.dart';
import 'package:stunting_project/data/consultation/consultation_models.dart';
import 'package:stunting_project/tokenmanager.dart';

class ConsultationService {
  final Dio _dio = Dio();
  final String protocol = 'https'; // or 'http'
  final String host = 'www.givxl33t.site'; // Replace with your API host
  final String getConsultationsPath =
      '/api/consultation/consultant?limit=3&page=1&filter=';

  ConsultationService() {
    _dio.options.baseUrl = '$protocol://$host';
    _dio.options.validateStatus = (status) {
      return status != null && status >= 200 && status <= 422;
    };
  }

  Future<List<Consultation>> getConsultations() async {
    try {
      print('Getting access token...');
      final accessToken = await TokenManager.getAccessToken();
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      print('Access token: $accessToken');

      final response = await _dio.get(
        getConsultationsPath,
        options: Options(headers: {
          'Authorization':
              'Bearer $accessToken', // Use the retrieved access token
        }),
      );

      print('Response: $response'); // Add this line
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print('Data: $data'); // Add this line
        return data.map((json) => Consultation.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Invalid or expired token. Please login again.');
      } else {
        if (response.data != null) {
          final message = response.data['message'];
          throw Exception(message ?? 'Unknown error');
        } else {
          throw Exception('Unknown error');
        }
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
