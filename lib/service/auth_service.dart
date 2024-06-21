import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();
  final String protocol = 'https'; // or 'http'
  final String host = 'www.givxl33t.site'; // Replace with your API host
  final String loginPath = '/api/auth/login';
  final String registerPath = '/api/auth/register';
  final String refreshTokenPath = '/api/auth/refresh'; // Add the refresh token endpoint
  final String userInfoPath = '/api/auth/me';
  final String logoutPath = '/api/auth/logout';

  String? _refreshToken;
  String? _accessToken;

  AuthService() {
    _dio.options.validateStatus = (status) {
      // Accept all status codes from 200 to 422 as valid responses
      return status != null && status >= 200 && status <= 422;
    };
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final String url = '$protocol://$host$loginPath';

    try {
      final response = await _dio.post(
        url,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _refreshToken = response.data['refreshToken'];
        _accessToken = response.data['accessToken'];
        return {
          'success': true,
          'refreshToken': _refreshToken,
          'accessToken': _accessToken,
        };
      } else {
        return {
          'success': false,
          'message': response.statusMessage,
        };
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        if (e.response?.statusCode == 422) {
          errorMessage = e.response?.data['message'] ?? 'Invalid email format';
        } else if (e.response?.statusCode == 400) {
          errorMessage = e.response?.data['message'] ?? 'Incorrect email or password';
        } else {
          errorMessage = e.response?.data['message'] ?? 'An error occurred';
        }
      }

      return {
        'success': false,
        'message': 'Error ${e.response?.statusCode}: $errorMessage',
      };
    }
  }

  Future<Map<String, dynamic>> register(String username, String email, String password) async {
    final String url = '$protocol://$host$registerPath'; // Correct the URL to use the registerPath
    
    try {
      final response = await _dio.post(
        url,
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': response.data['data'],
          'message': response.data['message'],
        };
      } else {
        return {
          'success': false,
          'message': 'Password harus menggunakan unsur uppercase',
        };
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'];

        if (statusCode == 400) {
          return {
            'success': false,
            'message': 'Email already exists',
          };
        } else if (statusCode == 422) {
          if (message == 'password is not strong enough') {
            return {
              'success': false,
              'message': 'Password is not strong enough',
            };
          } else if (message == 'email must be an email') {
            return {
              'success': false,
              'message': 'Email must be a valid email address',
            };
          }
        }
      }

      return {
        'success': false,
        'message': 'An error occurred: ${e.message}',
      };
    }
  }

  Future<Map<String, dynamic>> refreshToken() async {
    final String url = '$protocol://$host$refreshTokenPath';

    try {
      final response = await _dio.put(
        url,
        data: {
          'refreshToken': _refreshToken,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _refreshToken = response.data['refreshToken'];
        _accessToken = response.data['accessToken'];
        return {
          'success': true,
          'refreshToken': _refreshToken,
          'accessToken': _accessToken,
        };
      } else {
        return {
          'success': false,
          'message': response.statusMessage,
        };
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          errorMessage = 'Invalid or Expired token. Please login again.';
        } else {
          errorMessage = e.response?.data['message'] ?? 'An error occurred';
        }
      }

      return {
        'success': false,
        'message': 'Error ${e.response?.statusCode}: $errorMessage',
      };
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String accessToken) async {
    final String url = '$protocol://$host$userInfoPath';

    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'],
        };
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? 'An error occurred';
      }

      return {
        'success': false,
        'message': 'Error ${e.response?.statusCode}: $errorMessage',
      };
    }
  }

  Future<Map<String, dynamic>> logout(String refreshToken) async {
  final String url = '$protocol://$host$logoutPath';

  try {
    final response = await _dio.delete(
      url,
      data: {
        'refreshToken': refreshToken,
      },
      )
    ; // Debug print

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'User successfully logged out',
      };
    } else {
      return {
        'success': false,
        'message': response.data['message'] ?? 'Failed to log out user',
      };
    }
  } on DioException catch (e) {
    return {
      'success': false,
      'message': 'An error occurred: ${e.response?.data['message'] ?? e.message}',
    };
  }
}

}
