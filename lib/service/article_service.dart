import 'package:dio/dio.dart';
import '../data/article/article_models.dart';

class ArticleService {
  final Dio _dio = Dio();
  final String protocol = 'https'; // or 'http'
  final String host = 'www.givxl33t.site'; // Replace with your API host
  final String getArticlesPath = '/api/article';
  final String getArticleByIdPath = '/api/article/:articleId'; // Append article ID dynamically

  ArticleService() {
    _dio.options.baseUrl = '$protocol://$host';
    _dio.options.validateStatus = (status) {
      return status != null && status >= 200 && status <= 422;
    };
  }

  Future<List<Article>> getArticles({String? sort, int? limit, int? page}) async {
    final String url = '$protocol://$host$getArticlesPath';
    final queryParameters = <String, dynamic>{
      if (sort != null) 'sort': sort,
      if (limit != null) 'limit': limit,
      if (page != null) 'page': page,
    };

    try {
      final response = await _dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? 'Failed to load articles';
      }
      throw Exception(errorMessage);
    }
  }

  Future<Article> getArticleById(String articleId) async {
    final String url = '$protocol://$host$getArticleByIdPath';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return Article.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load article');
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? 'Failed to load article';
      }
      throw Exception(errorMessage);
    }
  }
}